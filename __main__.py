from argparse import ArgumentParser, Namespace
from glob import glob
from io import TextIOWrapper
from pandas import DataFrame
from pathlib import Path
from sqlite3 import Connection
from typing import Any

from src.get_audit_log_data import get_audit_log_data
from src.load_configuration import load_configuration
from src.sqlite import disconnect, get_connection, query, write


def main() -> None:
    arguments: Namespace = parse_arguments()
    configuration: dict[str, Any] = load_configuration(Path(__file__).parent.joinpath("config.json"), arguments.verbose)
    sqlite_connection: Connection = get_connection(configuration["SQLite"]["database"], arguments.verbose)

    if arguments.get_audit_log_data is not None:
        sqlite_connection.execute(f"DROP TABLE {configuration["SQLite"]["table"]};")

        if arguments.verbose:
            print(f'"{configuration["SQLite"]["table"]}" table dropped.')

        path: str

        if len(arguments.get_audit_log_data):
            path = arguments.get_audit_log_data

        else:
            path = configuration["SQLite"]["data"]
        
        data_frame: DataFrame = get_audit_log_data(path, arguments.verbose)
        write(data_frame, sqlite_connection, configuration["SQLite"]["table"], verbose=arguments.verbose)

    if arguments.list:
        paths: list[str] = glob("sql/**/*.sql", recursive=True)
       
        for path in paths:  
            print(Path(path).as_posix())

    if arguments.query:
        stream: TextIOWrapper = open(Path(__file__).parent.joinpath(arguments.query))
        sql: str = stream.read()
        stream.close()
        data = query(sql, sqlite_connection, arguments.verbose)
        print(data)

    if arguments.sage:
        from pyodbc import connect, Connection, Cursor, Row

        sqlserver_connection: Connection = connect(f"""DRIVER={configuration["SQLServer"]["driver"]};
SERVER={configuration["SQLServer"]["server"]},{configuration["SQLServer"]["port"]}\\{configuration["SQLServer"]["instance"]};
DATABASE={configuration["SQLServer"]["database"]};
UID={configuration["SQLServer"]["uid"]};
PWD={configuration["SQLServer"]["pwd"]};
Encrypt={configuration["SQLServer"]["encrypt"]};
TrustServerCertificate={configuration["SQLServer"]["trust_server_certificate"]};""")
        cursor: Cursor = sqlserver_connection.cursor()
        stream: TextIOWrapper = open(arguments.sage)
        sql: str = stream.read()
        stream.close()
        cursor.execute(sql)
        rows: list[Row] = cursor.fetchall()
        cursor.execute(sql)
        columns: list[str] = [column[0] for column in cursor.description]
        sqlserver_connection.close()
        row: Row
        print(columns)

        for row in rows:
            print(row)

    disconnect(sqlite_connection, verbose=arguments.verbose)


def parse_arguments() -> Namespace:
    argument_parser: ArgumentParser = ArgumentParser(description="PyLog: Python Log Analyzer")
    argument_parser.add_argument("-A", "--get_audit_log_data", nargs="?", const="", type=str, help="Get audit log data")
    argument_parser.add_argument("-l", "--list", action="store_true", help="List available queries")
    argument_parser.add_argument("-q", "--query", help="Query SQLite data")
    argument_parser.add_argument("-s", "--sage", help="Query Sage 300 data")
    argument_parser.add_argument("-v", "--verbose", action="store_true", help="Verbose")
    arguments: Namespace = argument_parser.parse_args()

    return arguments


if __name__ == "__main__":
    main()
