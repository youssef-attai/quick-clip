import os
import platform
import sys


def path_in_appdata_dir(path):
    p = None
    match platform.system():
        case "Linux":
            p = os.path.expanduser("~/.local/share")
        case "Windows":
            p = os.getenv("LOCALAPPDATA")
        case "Darwin":
            p = os.path.expanduser("~/Library/Application Support")
    return os.path.join(p, path)


def path_in_current_dir(path):
    application_path = None

    # determine if application is a script file or frozen exe
    if getattr(sys, 'frozen', False):
        application_path = os.path.dirname(sys.executable)
    elif __file__:
        application_path = os.path.dirname(__file__)

    return os.path.join(application_path, path)
