from ranger.api.commands import Command


class paste_as_root(Command):
    def execute(self):
        if self.fm.do_cut:
            self.fm.execute_console("shell sudo mv %c .")
        else:
            self.fm.execute_console("shell sudo cp -r %c .")


class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess
        import os.path

        if self.quantifier:
            # match only directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to file'"
        else:
            # match files and directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m --reverse --header='Jump to filemap <C-f> fzf_select'"
        fzf = self.fm.execute_command(
            command, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip("\n"))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class mkcd(Command):
    """
    :mkcd <dirname>

    Creates a directory with the name <dirname> and enters it.
    """

    def execute(self):
        from os.path import join, expanduser, lexists
        from os import makedirs
        import re

        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            makedirs(dirname)

            match = re.search("^/|^~[^/]*/", dirname)
            if match:
                self.fm.cd(match.group(0))
                dirname = dirname[match.end(0) :]

            for m in re.finditer("[^/]+", dirname):
                s = m.group(0)
                if s == ".." or (
                    s.startswith(".") and not self.fm.settings["show_hidden"]
                ):
                    self.fm.cd(s)
                else:
                    ## We force ranger to load content before calling `scout`.
                    self.fm.thisdir.load_content(schedule=False)
                    self.fm.execute_console("scout -ae ^{}$".format(s))
        else:
            self.fm.notify("file/directory exists!", bad=True)


class fasd(Command):
    """
    :fasd

    Jump to directory using fasd
    """

    def execute(self):
        args = self.rest(1).split()
        if args:
            directories = self._get_directories(*args)
            if directories:
                self.fm.cd(directories[0])
            else:
                self.fm.notify("No results from fasd", bad=True)

    def tab(self, tabnum):
        start, current = self.start(1), self.rest(1)
        for path in self._get_directories(*current.split()):
            yield start + path

    @staticmethod
    def _get_directories(*args):
        import subprocess

        output = subprocess.check_output(
            ["fasd", "-dl"] + list(args), universal_newlines=True
        )
        dirs = output.strip().split("\n")
        dirs.sort(reverse=True)  # Listed in ascending frecency
        return dirs


class fasd_dir(Command):
    def execute(self):
        import subprocess
        import os.path

        fzf = self.fm.execute_command(
            "fasd -dl | grep -iv cache | fzf 2>/dev/tty",
            universal_newlines=True,
            stdout=subprocess.PIPE,
        )
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip("\n"))
            print(fzf_file)
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
