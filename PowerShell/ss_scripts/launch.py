import os
import re
import sys

from colorama import Fore

path = os.path.dirname(__file__)
os.system("color")
scripts = [f.replace(".py", "") for f in os.listdir(path)]


def launch(script):
    try:
        os.system(f"python {path}/{script}.py")
    except KeyboardInterrupt:
        pass


if len(sys.argv) == 1:
    for s in scripts:
        print(
            re.sub(
                r"(?:(?<=-)|^)(\w)", fr"{Fore.LIGHTCYAN_EX}\1{Fore.LIGHTBLUE_EX}", s
            ).replace("-", f"{Fore.BLUE}-")
        )
    print(f"{Fore.LIGHTGREEN_EX}ss <filename>{Fore.GREEN} to Launch{Fore.RESET}")
else:
    script = sys.argv[1]
    if script in scripts:
        launch(script)
    else:
        launched = False
        for s in scripts:
            if s.startswith(script[0]):
                flag = True
                for c in script[1:]:
                    if "-" + c not in s:
                        flag = False
                        break
                if flag:
                    launched = True
                    launch(s)
                    break
        if not launched:
            print(f"{Fore.RED}Not found: {script}{Fore.RESET}")
