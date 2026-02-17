from argparse import ArgumentParser, Namespace
from glob import glob
from pandas import DataFrame, set_option
from pathlib import Path
from sqlalchemy import Engine
from sqlite3 import Connection as Connection
from typing import Any

from src.get_audit_log_data import get_audit_log_data
from src.load_configuration import load_configuration
from src.read import read
from src.sqlite import disconnect as disconnect_sqlite, get_connection as get_connection_sqlite, query as query_sqlite, write as write_sqlite
from src.sqlserver import get_connection as get_connection_sqlserver, query as query_sqlserver, disconnect as disconnect_sqlserver


def main() -> None:
    arguments: Namespace = parse_arguments()
    configuration: dict[str, Any] = load_configuration(Path(__file__).parent.joinpath("config.json"), arguments.verbose)
    connection_sqlite: Connection = get_connection_sqlite(configuration["SQLite"]["database"], arguments.verbose)

    set_option("display.max_rows", None)
    set_option("display.max_columns", None)
    set_option("display.width", None)

    if arguments.get_audit_log_data is not None:
        connection_sqlite.execute(f"DROP TABLE {configuration["SQLite"]["table"]};")

        if arguments.verbose:
            print(f'"{configuration["SQLite"]["table"]}" table dropped.')

        if len(arguments.get_audit_log_data):
            path: str = arguments.get_audit_log_data

        else:
            path: str = configuration["SQLite"]["data"]
        
        data_frame: DataFrame = get_audit_log_data(path, arguments.verbose)
        write_sqlite(data_frame, connection_sqlite, configuration["SQLite"]["table"], verbose=arguments.verbose)

    if arguments.list:
        paths: list[str] = glob("sql/**/*.sql", recursive=True)
        path: str
       
        for path in paths:  
            print(Path(path).as_posix())

    if arguments.query:
        sql: str = read(Path(__file__).parent.joinpath(arguments.query))
        data: DataFrame = query_sqlite(sql, connection_sqlite, arguments.verbose)
        print(data)
        file_path: Path = Path(str(arguments.query).replace("\\", "/").replace("sql/", "data/"))
        file_path.parent.mkdir(parents=True, exist_ok=True)
        data.to_html(file_path.with_suffix(".html"), index=False)

    if arguments.sage:
        connection_sqlserver: Engine = get_connection_sqlserver(
            configuration["SQLServer"]["driver"],
            configuration["SQLServer"]["server"],
            configuration["SQLServer"]["database"],
            configuration["SQLServer"]["uid"],
            configuration["SQLServer"]["pwd"],
            configuration["SQLServer"]["port"],
            configuration["SQLServer"]["instance"],
            configuration["SQLServer"]["encrypt"],
            configuration["SQLServer"]["trust_server_certificate"],
            arguments.verbose
        )
        sql: str = read(arguments.sage)
        data: DataFrame = query_sqlserver(sql, connection_sqlserver, arguments.verbose)
        disconnect_sqlserver(connection_sqlserver, verbose=arguments.verbose)
        print(data)
        print(f"\n{len(data)} record(s)")
        file_path: Path = Path(str(arguments.sage).replace("\\", "/").replace("sql/", "data/"))
        file_path.parent.mkdir(parents=True, exist_ok=True)
        data.to_html(file_path.with_suffix(".html"), index=False)

    disconnect_sqlite(connection_sqlite, verbose=arguments.verbose)


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
