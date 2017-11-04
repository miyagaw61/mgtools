from setuptools import setup, find_packages

console_scripts = [
        'pyenv_update=pyenv_update.pyenv_update:console_script',
        ]

setup(
    name='pyenv_update',
    version='0.0.1',
    packages=find_packages(),
    description='pyenv_update',
    author='Taisei Miyagawa @miyagaw61',
    author_email='miyagaw61@gmail.com',
    install_requires=['enert==0.0.2', 'better_exceptions'],
    dependency_links=['git+https://github.com/miyagaw61/enert.git#egg=enert-0.0.2'],
    entry_points = {'console_scripts': console_scripts},
    url='https://github.com/miyagaw61/mgtools',
    license='MIT'
)
