#!/usr/bin/env python3

from pytodoist import todoist
import yaml
import os
import stat
import argparse
from termcolor import colored
from pick import pick

parser = argparse.ArgumentParser(description='Manage Todoist from the command line.')
parser.add_argument('verb')
parser.add_argument('-m', dest='message', help='message or title for task or other object')
parser.add_argument('-i', dest='id', help='hexadecimal ID of task upon which to act')

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

# Check if group or public can read config and the private details therein.
# If so, warn user.
if os.stat(CONFIG_PATH).st_mode & (stat.S_IRGRP | stat.S_IROTH):
    # I just implemented my first actually useful code using bitwise operators.
    # It is 23:49 at night and I am supposed to be on vacation.
    # Send help.
    # TODO: Write to stderr, perhaps exit, or fix perms ourself?
    print('Warning: config file may be accessible by other users.')

user = todoist.login_with_api_token(config['token'])

def tasks_repr(tasks, color=True):
    # TODO: Support picking with color?
    return ['{id} {content}'.format(id=colored(hex(task.id)[2:], 'blue') if color else hex(task.id)[2:],
                                    content=colored(task.content, 'green') if color else task.content) for task in tasks]

if args.verb == 'list':
    for task in tasks_repr(user.get_tasks()):
        print(task)
elif args.verb == 'add':
    user.get_project('Inbox').add_task(args.message)
elif args.verb == 'del' or args.verb == 'delete':
    tasks = user.get_tasks()
    _, ind = pick(tasks_repr(tasks, color=False))
    # Another option is to simply use the method `complete`.
    # However, Todoist Premium may be required to get only uncompleted tasks.
    # So, for simplicity and just temporarily, let's delete.
    tasks[ind].delete()
