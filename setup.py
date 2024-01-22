import os
import sys
import shutil
from pathlib import Path

home = os.getenv("HOME")
cwd = os.path.dirname(__file__)


def install(is_link, direcotry, message):
    data_path = os.path.join(cwd, direcotry)
    for src in list(Path(data_path).rglob("*")):
        if os.path.isdir(src):
            continue

        rel = os.path.relpath(src, data_path)
        dst = os.path.join(home, rel)

        exists = False
        if os.path.exists(dst):
            real = os.path.realpath(dst)
            if real == str(src):
                continue
            else:
                exists = True
        do = True
        if exists:
            while True:
                ans = input("{} exists. (r)etry/(s)kip/(f)orce: ".format(dst))
                if ans == "s":
                    do = False
                    break
                elif ans == "f":
                    os.remove(dst)
                    break
                elif ans == "r":
                    if not os.path.exists(dst):
                        break
        if do:
            print(message + dst)
            parent = os.path.dirname(dst)
            os.makedirs(parent, exist_ok=True)

            if is_link:
                os.symlink(os.path.relpath(src, os.path.dirname(dst)), dst)
            else:
                shutil.copy(src, dst)


not "--skip-link" in sys.argv and install(True, "link", "link ")
not "--skip-copy" in sys.argv and install(False, "copy", "copy ")

os.system(os.path.join(cwd, "post-setup.sh"))
