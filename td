#!/usr/bin/env python3

import todoist
import yaml
import os

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
        config[key] = input(key + ': ')
    with open(CONFIG_FILE, 'w') as f:
        yaml.dump(config, f)


api = todoist.TodoistAPI(config['token'])
#user = api.user.login(config['email'], config['token'])
response = api.sync()

print(response)
