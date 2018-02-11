from enert import *
import better_exceptions

if argc < 3:
    usage = 'Usage: pyenv_updage [python2_version] [python3_version]'
    print(usage)
    exit()

def get_versions():
    versions, err = Shell('pyenv versions').readline()
    if err:
        for x in err:
            print(red(x, 'bold'))
    if not versions:
        exit()
    return versions, err

def get_2and3_list(versions):
    python2_list = []
    python3_list = []
    for i in range(len(versions)):
        versions[i] = sed(versions[i], '\s', '')
        tmp = grep(versions[i], '\*(.*?)\(')
        if tmp:
            now = tmp[0]
            versions[i] = now
        is_python2 = False
        is_python2 = len(grep(versions[i], '^2\.')) > 0
        is_python3 = False
        is_python3 = len(grep(versions[i], '^3\.')) > 0
        if is_python2:
            python2_list.append(versions[i])
        if is_python3:
            python3_list.append(versions[i])
    return python2_list, python3_list

def debug_python_list(python2_list, python3_list):
    print('Python2 list: ')
    print(python2_list)
    print('Python3 list: ')
    print(python3_list)

def get_env_list(python2_list, python3_list):
    python2_env_list = []
    python3_env_list = []
    for i in range(len(python2_list)):
        tmp = grep(python2_list[i], '/envs/(.*)')
        if tmp:
            for x in tmp: python2_env_list.append(x)
    for i in range(len(python3_list)):
        tmp = grep(python3_list[i], '/envs/(.*)')
        if tmp:
            for x in tmp: python3_env_list.append(x)
    return python2_env_list, python3_env_list

def update_version(python2_version, python3_version, python2_list, python3_list, python2_env_list, python3_env_list):
    if python2_version in python2_list:
        print('Not Update python2')
        python2_list = []
        python2_env_list = []
    else:
        print('Update python2')
        Shell('pyenv install ' + python2_version).call()
    if python3_version in python3_list:
        print('Not Update python3')
        python3_list = []
        python3_env_list = []
    else:
        print('Update python3')
        Shell('pyenv install ' + python3_version).call()
    return python2_list, python3_list, python2_env_list, python3_env_list

def uninstall_version(python2_list, python3_list):
    print('Uninstall python2:')
    print(python2_list)
    for i in range(len(python2_list)):
        Shell('pyenv uninstall -f ' + python2_list[i]).call()
    print('Uninstall python3:')
    print(python3_list)
    for i in range(len(python3_list)):
        Shell('pyenv uninstall -f ' + python3_list[i]).call()

def update_env(python2_version, python3_version, python2_env_list, python3_env_list):
    print('Update python2 virtualenv:')
    print(python2_env_list)
    for i in range(len(python2_env_list)):
        Shell('pyenv virtualenv ' + python2_version + ' ' + python2_env_list[i]).call()
    print('Update python3 virtualenv:')
    print(python3_env_list)
    for i in range(len(python3_env_list)):
        Shell('pyenv virtualenv ' + python3_version + ' ' + python3_env_list[i]).call()

def main(python2_version, python3_version):
    versions, err = get_versions()
    python3_flag = False
    python2_flag = False
    now = ''
    python2_list, python3_list = get_2and3_list(versions)
    debug_python_list(python2_list, python3_list)
    python2_env_list, python3_env_list = get_env_list(python2_list, python3_list)
    python2_list, python3_list, python2_env_list, python3_env_list = update_version(python2_version, python3_version, python2_list, python3_list, python2_env_list, python3_env_list)
    uninstall_version(python2_list, python3_list)
    update_env(python2_version, python3_version, python2_env_list, python3_env_list)

def console_script():
    main(argv[1], argv[2])
    
if __name__ == '__main__':
    main(argv[1], argv[2])
