import os


def path_in_current_dir(path):
    return os.path.join(os.path.dirname(__file__), path)
