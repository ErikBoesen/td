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
    config = [input(key + ': ') for key in config.keys()]
    with open(CONFIG_PATH, 'w') as f:
        yaml.dump(config, f)

# TODO: Token login
api = todoist.login_with_api_token(config['token'])
# TODO: Bypass Inbox project entirely
inbox = api.get_project('Inbox')

if args.verb == 'list':
    for task in api.get_tasks():
        print('{id} {content}'.format(id=colored(hex(task.id)[2:], 'blue'),
                                      content=colored(task.content, 'green')))
elif args.verb == 'add':
    inbox.add_task(args.message)
