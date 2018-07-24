# `td` for Todoist
> A minimal command-line tool for managing checklists on [Todoist](https://todoist.com).

Disclaimer: `td` is not created by, affiliated with, or supported by Doist.

## Installation
From the `td` directory, run:
```sh
make install
```
for a full installation.

Alternatively, if you're working on `td` in a development environment, you may wish to symlink the executable for ease of testing:
```sh
make link
```
To uninstall:
```sh
make uninstall
```
Any of these commands may require root privileges depending on your environment.

## Use
To list all tasks:
```sh
td list
```
To add a task:
```sh
td add -m "Title of task"
```
To delete a task:
```sh
td delete  # or del
# select task for deletion in interactive list
```

## License
[MIT](LICENSE)

## Author
[Erik Boesen](https://github.com/ErikBoesen)
