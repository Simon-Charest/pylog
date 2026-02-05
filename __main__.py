from argparse import Namespace
from glob import glob
from io import TextIOWrapper
from pandas import DataFrame
from pathlib import Path
from sqlite3 import Connection
from typing import Any

from src.load_configuration import load_configuration
from src.get_audit_log_data import get_audit_log_data
from src.sqlite import disconnect, get_connection, query, write


def main() -> None:
    arguments: Namespace = parse_arguments()
    configuration: dict[str, Any] = load_configuration(Path(__file__).parent.joinpath("config.json"), arguments.verbose)
    connection: Connection = get_connection(configuration["database"], arguments.verbose)

    if arguments.get_audit_log_data is not None:
        path: str

        if len(arguments.get_audit_log_data):
            path = arguments.get_audit_log_data

        else:
            path = configuration["data"]
        
        data_frame: DataFrame = get_audit_log_data(path, arguments.verbose)
        write(data_frame, connection, configuration["table"], verbose=arguments.verbose)

    if arguments.list:
        paths: list[str] = glob("sql/**/*.sql", recursive=True)
       
        for path in paths:  
                print(Path(path).as_posix())

    if arguments.query:
        stream: TextIOWrapper = open(Path(__file__).parent.joinpath(arguments.query))
        sql: str = stream.read()
        stream.close()
        data = query(sql, connection, arguments.verbose)
        print(data)

    disconnect(connection, verbose=arguments.verbose)


def parse_arguments() -> Namespace:
    from argparse import ArgumentParser, Namespace

    argument_parser: ArgumentParser = ArgumentParser(description="PyLog: Python Microsoft Log Analyzer")
    argument_parser.add_argument("-A", "--get_audit_log_data", nargs="?", const="", type=str, help="Get audit log data")
    argument_parser.add_argument("-l", "--list", action="store_true", help="List available queries")
    argument_parser.add_argument("-q", "--query", help="Query data")
    argument_parser.add_argument("-v", "--verbose", action="store_true", help="Verbose")
    arguments: Namespace = argument_parser.parse_args()

    return arguments


if __name__ == "__main__":
    main()
