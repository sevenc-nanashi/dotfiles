from colorama import Fore
from pyperclip import copy, paste

pasted = paste()
txt = pasted[:-1] + "".join(reversed(pasted.replace("\r\n", "\n"))).strip()
copy(txt)
first = f"{Fore.LIGHTBLACK_EX}|{Fore.RESET}"
ftxt = ("\n" + first).join(txt.splitlines())
print(f"{Fore.YELLOW}Copied:{Fore.RESET}\n{first}{ftxt}")
