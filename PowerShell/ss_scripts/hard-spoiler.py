from colorama import Fore
import pyperclip

txt = "".join([f"||{c}||" for c in pyperclip.paste()]).strip()
pyperclip.copy(txt)
print(f"{Fore.YELLOW}Copied: {Fore.RESET}{txt}")
