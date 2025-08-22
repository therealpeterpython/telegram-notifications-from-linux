"""
Example for the usage of the notify-checker.sh script.
You can find this script here: https://github.com/therealpeterpython/telegram-notifications-from-linux

Created by therealpeterpython (2025)
"""
import os
from pathlib import Path


def notify(msg, tg_dir, options=""):
    """
    Sends a message via telegram.
    :param msg: String with the message text
    :param tg_dir: Telegram directory containing the notify-checker.sh script as Path object
    :param options: Options will be handed to the telegram-notify.sh script
    """
    # Make sure the dir exists
    tg_dir.mkdir(parents=True, exist_ok=True)

    # Write the informations
    with open(tg_dir / "infos", "w") as fp:
        fp.write("send = true\n")
        fp.write("message = "+str(msg)+"\n")
        fp.write("options ="+str(options)+"\n")

    # Trigger send script
    os.system(tg_dir / "notify-checker.sh infos tokens")


if __name__ == "__main__":  
    value = 7
    notify(msg=f"The program is done with result {value}!", tg_dir=Path(".."), options="--success")