#!/usr/bin/env python

"""
After making a stash, loops through each data/stashed/ subdirectory and adds/commits/pushes the changes
"""

from sys import path as syspath; syspath.append('./scripts')
from utils.myfiler import get_latest_snapshot_dir
from utils.mylog import *

from pathlib import Path
import subprocess

SRC_DIR = Path('data/stashed')


def main():
    dt = get_latest_snapshot_dir().name
    myinfo(f"Current dt: {dt}")

    for datadir in [d for d in SRC_DIR.iterdir() if d.is_dir()]:
        cmds = (["git", "add", str(datadir)],
            ["git", "commit", "-m", f"'{datadir.name} {dt}'"],
            ['git', 'push'],)

        for cmd in cmds:
            myinfo(' '.join(cmd))
            subprocess.run(cmd)

if __name__ == '__main__':
    main()
