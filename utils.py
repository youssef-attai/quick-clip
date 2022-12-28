import os
import platform


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
    return os.path.join(os.path.dirname(__file__), path)
