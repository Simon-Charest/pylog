from pandas import NA, DataFrame, read_sql
from sqlalchemy import create_engine
from sqlalchemy.engine import Engine
from urllib.parse import quote_plus


def get_connection(
    driver: str,
    server: str,
    database: str,
    uid: str,
    pwd: str,
    port: int = 1433,
    instance: str = "MSSQLSERVER",
    encrypt: bool = False,
    trust_server_certificate: bool = False,
    verbose: bool = False
) -> Engine:
    if encrypt:
        encrypt_string: str = "yes"

    else:
        encrypt_string: str = "no"

    if trust_server_certificate:
        trust_server_certificate_string: str = "yes"
        
    else:
        trust_server_certificate_string: str = "no"

    string: str = (
        f"DRIVER={driver};"
        f"SERVER={server},{port}\\{instance};"
        f"DATABASE={database};"
        f"UID={uid};"
        f"PWD={pwd};"
        f"Encrypt={encrypt_string};"
        f"TrustServerCertificate={trust_server_certificate_string};"
    )
    url: str = (f"mssql+pyodbc:///?odbc_connect={quote_plus(string)}")
    engine: Engine = create_engine(url)

    if verbose:
        print(f'Connected to database "{database}".')

    return engine


def query(sql: str, connection: Engine, verbose: bool = False) -> DataFrame:
    if verbose:
        print("Querying database...")

    data_frame: DataFrame = read_sql(sql, connection).fillna("")


    if verbose:
        print(f"Fetched {len(data_frame)} row(s).")

    return data_frame


def disconnect(connection: Engine, verbose: bool = False) -> None:
    connection.dispose()

    if verbose:
        print("Disconnected from database.")
