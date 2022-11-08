from ranger.api.commands import Command

class togetherize(Command):
    """:togetherize <dirname>

    Creates a directory with the name <dirname> and move selected files to it.
    """

    def execute(self):
        import os
        from os import path
        cwd = self.fm.thisdir.path
        if self.arg(1):
            dirname = path.join(cwd, path.expanduser(self.rest(1)))
        else:
            dirname = path.join(cwd, path.basename(cwd))

        os.makedirs(dirname, exist_ok=True)
        
        if not path.isdir(dirname):
            self.fm.notify("failed to create the directory", bad=True)
            return

        if len(self.fm.thisdir.marked_items) == 0:
            return

        import shutil
        for f in self.fm.thisdir.marked_items:
            shutil.move(f.realpath, dirname)

class rcp(Command):
    """:rcp

    Paste the selected items into the current directory using rcp/rmv
    """

    term = "alacritty"

    def execute(self):
        if len(self.fm.copy_buffer) == 0:
            return

        command = [self.term, "-e", "rmv" if self.fm.do_cut else "rcp"]
        for file in self.fm.copy_buffer:
            command.append(file.path)

        if self.arg(1):
            command.append(self.arg(1))
        else:
            command.append(self.fm.thisdir.path)

        import subprocess
        subprocess.Popen(command)

        self.fm.copy_buffer = set()
        self.do_cut = False

class isolate(Command):
    """:isorate <level>

    Create a directory with the same name as the parent directory and move selected items into it
    Repeat <level> times
    """

    def execute(self):
        if not self.arg(1):
            self.fm.notify("isolate requires <level> argument", bad=True)
            return

        level = int(self.rest(1))

        import os

        cwd = self.fm.thisdir.path
        elms = cwd.split(os.sep)
        el = len(elms)
        child = elms[(el - level if level < el else 0):]
        dest = os.path.join(cwd, *child)
        os.makedirs(dest, exist_ok=True)

        import shutil
        if len(self.fm.thisdir.marked_items) == 0:
            shutil.move(self.fm.thisfile.realpath, dest)
            return

        for f in self.fm.thisdir.marked_items:
            shutil.move(f.realpath, dest)
