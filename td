#!/usr/bin/env python3

import todoist
import yaml
import os

CONFIG_FILE = '.td.yml'
with open(os.path.expanduser('~') + '/' + CONFIG_FILE, 'r') as f:
    config = yaml.load(f)

api = todoist.TodoistAPI(config['token'])
#user = api.user.login(config['email'], config['token'])
response = api.sync()

print(response)
