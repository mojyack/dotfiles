from ranger.api.commands import Command

class togetherize(Command):
    """:togetherize <dirname>

    Creates a directory with the name <dirname> and move selected files to it.
    """

    def execute(self):
        if not self.arg(1):
            self.fm.notify(":togetherize needs a dirname.", bad=True)
            return
        
        import os
        from os import path
        dirname = path.join(self.fm.thisdir.path, path.expanduser(self.rest(1)))
        if not path.lexists(dirname):
            os.makedirs(dirname)
        
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
