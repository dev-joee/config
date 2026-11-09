from ranger.api.commands import Command
import os
import subprocess
from datetime import datetime

# --------------------------
# Make Directory
# --------------------------
class mkdir(Command):
    def execute(self):
        name = self.arg(1) or input("Directory Name: ")
        os.makedirs(name, exist_ok=True)

# --------------------------
# Make File
# --------------------------
class mkfile(Command):
    def execute(self):
        name = self.arg(1) or input("File Name: ")
        open(name, "a").close()

# --------------------------
# Set Wallpaper (feh)
# --------------------------
class setwallpaper(Command):
    def execute(self):
        if self.rest(1):
            subprocess.run(["feh", "--bg-scale", self.rest(1)])
        else:
            subprocess.run(["feh", "--bg-scale", self.fm.thisfile.path])

# --------------------------
# Archive Extraction
# --------------------------
class unarchive(Command):
    def execute(self):
        f = self.fm.thisfile.path
        if f.endswith(".zip"):
            subprocess.run(["unzip", f])
        elif f.endswith(".rar"):
            subprocess.run(["unrar", "x", f])
        elif f.endswith(".tar.gz"):
            subprocess.run(["tar", "-xzvf", f])
        elif f.endswith(".tar.bz2"):
            subprocess.run(["tar", "-xjvf", f])
        elif f.endswith(".tar"):
            subprocess.run(["tar", "-xvf", f])
        elif f.endswith(".7z"):
            subprocess.run(["7z", "e", f])
        else:
            self.fm.notify("Unsupported format", bad=True)

# --------------------------
# Trash (requires trash-cli)
# --------------------------
class trash(Command):
    def execute(self):
        files = self.fm.thistab.get_selection()
        for f in files:
            subprocess.run(["trash-put", f.path])

# --------------------------
# Delete
# --------------------------
class delete(Command):
    def execute(self):
        files = self.fm.thistab.get_selection()
        ans = input("Delete selected files/directories? [y/N] ")
        if ans.lower() == "y":
            for f in files:
                if os.path.isdir(f.path):
                    subprocess.run(["rm", "-rf", f.path])
                else:
                    os.remove(f.path)

# --------------------------
# Open (Neovim for empty/text, xdg-open otherwise)
# --------------------------
class open(Command):
    def execute(self):
        files = self.fm.thistab.get_selection()
        for f in files:
            if not os.path.exists(f.path):
                continue
            mime = subprocess.run(["file", "--mime-type", "-Lb", f.path], capture_output=True, text=True).stdout.strip()
            if os.path.getsize(f.path) == 0 or mime.startswith("text/"):
                subprocess.run(["nvim", f.path])
            else:
                subprocess.run(["xdg-open", f.path])

# --------------------------
# Help
# --------------------------
class help(Command):
    def execute(self):
        subprocess.run(["less", os.path.expanduser("~/.config/ranger/manual")])
