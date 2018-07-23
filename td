#!/usr/bin/env python3

from pytodoist import todoist
import yaml
import os
from getpass import getpass
import argparse

CONFIG_FILE = os.path.expanduser('~') + '/.td.yml'
config = {
    'email': '',
    'password': '',
    'token': '',
}
if os.path.isfile(CONFIG_FILE):
    with open(CONFIG_FILE, 'r') as f:
        config = yaml.load(f)
else:
    for key in config.keys():
        config[key] = getpass(prompt=key + ': ') if key == 'password' else input(key + ': ')
    with open(CONFIG_FILE, 'w') as f:
        yaml.dump(config, f)

# TODO: Token login
api = todoist.login(config['email'], config['password'])

parser = argparse.ArgumentParser(description='Manage Todoist from the command line.')
parser.add_argument('verb')

args = parser.parse_args()

if args.verb == 'list':
    for task in api.get_tasks():
        print('{id:x} {content}'.format(id=task.id,
                                        content=task.content))
