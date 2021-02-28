import os
import shutil
from pathlib import Path

HOME = os.getenv("HOME")
PWD = os.path.dirname(__file__)

def install(is_link, direcotry, message):
    DATA_PATH = PWD + "/" + direcotry
    DATAS = list(Path(DATA_PATH).rglob("*"))
    for src in DATAS:
        if(os.path.isdir(src)):
            continue
    
        rel = os.path.relpath(src, DATA_PATH)
        dst = HOME + "/" + rel
        
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
            parent = Path(dst).parent
            if not os.path.exists(parent):
                os.makedirs(parent)
    
            if(is_link):
                os.symlink(src, dst)
            else:
                shutil.copy(src, dst)

install(True, "link", "link ")
install(False, "copy", "copy ")

os.system(PWD + "/post-setup.sh")
