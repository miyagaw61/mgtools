#!/home/miyagaw61/.pyenv/shims/python
from enert import *
from argparse import ArgumentParser

#make argparser
argparser = ArgumentParser(usage="mkpyenv [v <version>] [venv <name>]")

#add arg
#argparser.add_argument("command", type=str, help="require")

#make subparsers
subparsers = argparser.add_subparsers()

#make subparser
parser_v = subparsers.add_parser("v", help="python version change", usage="mkpyenv v [version]")
parser_venv = subparsers.add_parser("venv", help="virtualenv", usage="mkpyenv venv [name]")

#add arg
parser_v.add_argument("version", type=str, help="2 or 3")
parser_venv.add_argument("name", type=str, help="vrtualenv directory name")

#compile
args = argparser.parse_args()

#switch
if "version" in args:
    if args.version == "2":
        print("2")
    if args.version == "3":
        print("3")
elif "name" in args:
    print(args.name)
