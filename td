#!/usr/bin/env python3

from pytodoist import todoist
import yaml
import os
import argparse
from termcolor import colored


parser = argparse.ArgumentParser(description='Manage Todoist from the command line.')
parser.add_argument('verb')
parser.add_argument('-m', dest='message', help='message or title for task or other object')

args = parser.parse_args()

CONFIG_PATH = os.path.expanduser('~') + '/.td.yml'
config = {
    'token': '',
}
if os.path.isfile(CONFIG_PATH):
    with open(CONFIG_PATH, 'r') as f:
        config = yaml.load(f)
else:
    for key in config.keys():
        config[key] = input(key + ': ')
    with open(CONFIG_PATH, 'w') as f:
        yaml.dump(config, f)

# TODO: Token login
api = todoist.login(config['email'], config['password'])
# TODO: Bypass Inbox project entirely
inbox = api.get_project('Inbox')

if args.verb == 'list':
    for task in api.get_tasks():
        print('{id:x} {content}'.format(id=colored(task.id, 'blue'),
                                        content=colored(task.content, 'green')))
elif args.verb == 'add':
    inbox.add_task(args.message)
