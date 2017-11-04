from setuptools import setup, find_packages

console_scripts = [
        'git2nd=git2nd.git2nd:main',
        'gi=git2nd.git2nd:main',
        ]

setup(
    name='git2nd',
    version='0.0.1',
    packages=find_packages(),
    description='git2nd',
    author='Taisei Miyagawa @miyagaw61',
    author_email='miyagaw61@gmail.com',
    install_requires=['enert==0.0.2', 'better_exceptions'],
    dependency_links=['git+https://github.com/miyagaw61/enert.git#egg=enert-0.0.2'],
    entry_points = {'console_scripts': console_scripts},
    url='https://github.com/miyagaw61/git2nd',
    license='MIT'
)
