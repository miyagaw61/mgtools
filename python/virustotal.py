import requests
import sys
from enert import *

def main():
    usage = '''\
Usage: virustotal [file] [ -d directory]\
'''
    p = mkparser(usage)
    p.add_argument('-d', '--directory', dest='directory')
    a = p.parse_args(argv[1:])

    if a.help:
        print(usage)
        exit(0)
    elif a.directory:
        files, _ = Shell('rg --files ' + a.directory).readlines()
        for x in files:
            analyze(x)
    else:
        analyze(a.args[0])

def analyze(file_name):
    key = '7d33147b6341f1d4ce274395b7fd7ba75438eed6b3c00ad85956fd03aea83a8d'
    params = {'apikey': key}
    files = {'file': (file_name, open(file_name, 'rb'))}
    response = requests.post('https://www.virustotal.com/vtapi/v2/file/scan', files=files, params=params)
    json_response = response.json()
    for k,v in json_response.items():
        key = k + ' : '
        print(key.ljust(20) + str(v))
    Shell('chrome ' + json_response['permalink']).call()

if __name__ == '__main__':
    main()
