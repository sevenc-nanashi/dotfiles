from colorama import Fore
import pyperclip

txt = "   ".join(pyperclip.paste())
pyperclip.copy(txt)
print(f"{Fore.YELLOW}Copied: {Fore.RESET}{txt}")
