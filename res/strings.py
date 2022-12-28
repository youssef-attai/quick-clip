import os

from utils import path_in_current_dir, path_in_appdata_dir

APP_NAME = "Quick clipboard"
ICON_PATH = path_in_current_dir("imgs/clipboard.png")
APPDATA_DIR = path_in_appdata_dir("quickclipboard")
DATABASE_DIR = os.path.join(APPDATA_DIR, "texts.db")
ADD_NEW_TEXT_DIALOG_TITE = "Add a new text"
