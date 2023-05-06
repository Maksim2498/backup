# Backup

## About

This  is  a  bash  script  that manages backups. It creates a backup of
target  file  passed  to  it as the first argument in the backup folder
passed  to  it as the secod argument. If backup folder doesn't exist it
will be created. Backups are stored as `.tag.gz` archives with name set
to  it's  creation  date.  By  default  this script will create up to 5
backups  removing  old  ones  on  attempt  to  create  a  new one. This
behaviour  can  be  overridden  by  passing  an  -m (or --max) argument
set to desired amount.

## Usage

backup [options] <path to target> <path to backup folder>

## Options

| Option(s)         | Description                                                  |
|-------------------|--------------------------------------------------------------|
| `-h`, `--help`    | Print help                                                   |
| `-v`, `--verbose` | Enable verbose mode                                          |
| `-m`              | Specify maximum number of backup entries. Default value is 5 |

## Install

Run `install.sh` script with root privileges as follows:

```console
sudo ./install.sh
```

It will copy `script.sh` file as `/usr/bin/backup`.

## Uninstall

Run `uninstall.sh` script with root privileges as follows:

```console
sudo ./uninstall.sh
```

It will remove `/usr/bin/backup`.
