from argparse import Namespace
from json import dumps
from typing import Any
from pandas import DataFrame, concat, json_normalize, option_context, read_csv, read_sql
from pathlib import Path
from sqlite3 import Connection, connect


def main() -> None:
    arguments: Namespace = parse_arguments()
    configuration: dict[str, Any] = load_configuration(arguments.verbose)
    connection: Connection = get_connection(configuration.get("database"), arguments.verbose)
    data_frame: DataFrame

    if arguments.read is not None:
        if len(arguments.read):
            data_frame = read(arguments.read, arguments.verbose)

        else:
            data_frame = read(configuration.get("data"), arguments.verbose)

        write(data_frame, connection, configuration.get("table"), verbose=arguments.verbose)

    if arguments.query:
        data_frame = query(connection, configuration.get("table"), arguments.verbose)

        with option_context("display.max_columns", None, "display.max_colwidth", None):
            print(data_frame.iloc[0])

    if arguments.ip:
        data_frame = get_ips(connection, configuration.get("table"), arguments.verbose)
        print(data_frame.head(1))

    disconnect(connection, verbose=arguments.verbose)


def parse_arguments() -> Namespace:
    from argparse import ArgumentParser, Namespace

    argument_parser: ArgumentParser = ArgumentParser(description="USB drive inspection and read-only control")
    argument_parser.add_argument("-r", "--read", nargs="?", const="", type=str, help="Read CSV logs from files")
    argument_parser.add_argument("-q", "--query", action="store_true", help="Query the database")
    argument_parser.add_argument("-i", "--ip", action="store_true", help="Get IP addresses from the database")
    argument_parser.add_argument("-v", "--verbose", action="store_true", help="Verbose")
    arguments: Namespace = argument_parser.parse_args()

    return arguments


def load_configuration(verbose: bool = False) -> dict[str, Any]:
    from json import load

    configuration: dict[str, Any] = load(open(Path(__file__).parent.joinpath("config.json")))

    if verbose:
        print("Configuration loaded.")

    return configuration


def get_connection(database: Path, verbose: bool = False) -> Connection:
    connection: Connection = connect(database)

    if verbose:
        print(f'Connected to database "{database}".')

    return connection


def read(path: str, verbose: bool = False) -> DataFrame:
    from glob import glob
    from json import loads
    
    paths: list[str] = glob(path)

    if verbose:
        print(f"Reading CSV {len(paths)} file(s)...")

    data_frame: DataFrame = concat((read_csv(path, converters={"AuditData": loads}) for path in paths), ignore_index=True)

    if verbose:
        print(f"Read file(s).")
    
    data_frame = data_frame.join(json_normalize(data_frame.pop("AuditData")), rsuffix="_json")

    if verbose:
        print(f"Normalized JSON data.")

    return data_frame


def write(data_frame: DataFrame, connection: Connection, name: str, if_exists: str = "replace", index: bool = False, verbose: bool = False) -> None:
    for column in data_frame.columns:
        if data_frame[column].map(lambda obj: isinstance(obj, (list, dict))).any():
            data_frame[column] = data_frame[column].map(dumps)

    if verbose:
        print(f"Convert unhashable object(s) to JSON string(s).")

    data_frame = data_frame.drop_duplicates()

    if verbose:
        print(f"Removed duplicate(s).")
    
    data_frame.to_sql(name, connection, if_exists=if_exists, index=index)

    if verbose:
        print(f"Wrote {len(data_frame)} row(s) to database.")


def query(connection: Connection, table: str,verbose: bool = False) -> DataFrame:
    if verbose:
        print(f"Querying database...")

    sql: str = f"SELECT * FROM {table} LIMIT 10;"
    data_frame: DataFrame = read_sql(sql, connection)
    
    if verbose:
        print(f"Fetched {len(data_frame)} row(s).")

    return data_frame


def get_ips(connection: Connection, table: str, verbose: bool = False) -> DataFrame:
    if verbose:
        print(f"Getting IP addresses from database...")
        
    sql: str = f"SELECT DISTINCT ClientIPAddress FROM {table};"
    data_frame: DataFrame = read_sql(sql, connection)
    
    if verbose:
        print(f"Fetched {len(data_frame)} row(s).")

    return data_frame


def disconnect(connection: Connection, verbose: bool = False) -> None:
    connection.close()

    if verbose:
        print("Disconnected from database.")


if __name__ == "__main__":
    main()
