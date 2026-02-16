from json import dumps, loads
from pandas import DataFrame, concat, json_normalize, read_csv

from src.get_paths import get_paths


def get_audit_log_data(path: str, verbose: bool = False) -> DataFrame:
    paths: list[str] = get_paths(path)
    data_frame: DataFrame = read(paths, verbose)
    data_frame = deduplicate_columns(data_frame, verbose)
    data_frame = make_hashable(data_frame, verbose)
    data_frame = deduplicate_rows(data_frame, verbose)

    return data_frame


def read(paths: list[str], verbose: bool = False) -> DataFrame:
    if verbose:
        print(f"Reading CSV {len(paths)} file(s)...")

    data_frame: DataFrame = concat((read_csv(path, converters={"AuditData": loads}) for path in paths), ignore_index=True)
    data_frame = data_frame.drop(columns=["AuditData"]).join(json_normalize(data_frame["AuditData"]).add_prefix("AuditData_"))

    if verbose:
        print(f"{len(data_frame)} row(s) read.")

    return data_frame


def deduplicate_columns(data_frame: DataFrame, verbose: bool = False) -> DataFrame:
    columns: list[str] = [column for column in data_frame.columns if column.endswith("CorrelationID")]
    data_frame["AuditData_CorrelationID"] = data_frame[columns].bfill(axis=1).iloc[:, 0]
    data_frame = data_frame.drop(columns=columns)

    if verbose:
        print(f"Columns deduplicated: {len(data_frame.columns)} column(s) remaining.")

    return data_frame


def make_hashable(data_frame: DataFrame, verbose: bool = False) -> DataFrame:
    column: str

    for column in data_frame.columns:
        data_frame[column] = data_frame[column].map(lambda obj: dumps(obj, sort_keys=True) if isinstance(obj, (list, dict)) else obj)

    if verbose:
        print(f"Made JSON data hashable.")

    return data_frame


def deduplicate_rows(data_frame: DataFrame, verbose: bool = False) -> DataFrame:
    data_frame = data_frame.drop_duplicates()
 
    if verbose:
        print(f"Rows deduplicated: {len(data_frame)} row(s) remaining.")

    return data_frame
