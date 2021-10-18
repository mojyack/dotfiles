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
