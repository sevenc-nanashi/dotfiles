from colorama import Fore
from pyperclip import copy, paste

txt = "".join(reversed(paste().replace("\r\n", "\n"))).strip()
copy(txt)
ftxt = ("\n  ").join(txt.splitlines())
print(f"{Fore.YELLOW}Copied:{Fore.RESET}\n  {ftxt}")
