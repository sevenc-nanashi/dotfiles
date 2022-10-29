import json
import os

# import re
import sys
import urllib.parse

from colorama import Fore
import pyperclip


os.system("color")
if len(sys.argv) > 1:
    with open(sys.argv[1], encoding="utf-8-sig") as r:
        rd = r.read()
else:
    rd = sys.stdin.buffer.read().decode("utf-8-sig")
if not rd:
    rd = pyperclip.paste().replace("\r\n", "\n")
try:
    data = json.loads(rd)
except json.JSONDecodeError:
    http_data = rd.split("\n\n", 2)
    headers = http_data[0]
    for h in headers.splitlines():
        s = h.split(": ", 2)
        if len(s) == 1:
            print(Fore.LIGHTBLACK_EX + s[0])
        else:
            k, v = s
            print(
                Fore.LIGHTBLACK_EX
                + k
                + Fore.RESET
                + ": "
                + Fore.WHITE
                + urllib.parse.unquote(v)
            )
    print(Fore.RESET)
    json_data = http_data[1]
    data = json.loads(json_data)
colors = [Fore.RED, Fore.YELLOW, Fore.GREEN, Fore.CYAN, Fore.BLUE, Fore.MAGENTA]


def main(data):
    status = None
    isbs = False
    current_loop = -1
    res = ""
    ac = False
    # res += ""
    for c in data:
        if status == '"':
            if isbs:
                isbs = False
                res += c + (Fore.LIGHTCYAN_EX if ac else Fore.LIGHTGREEN_EX)
                continue
            elif c == "\\":
                res += Fore.RESET + (Fore.LIGHTBLUE_EX if ac else Fore.LIGHTCYAN_EX)
                isbs = True
            elif c == '"':
                status = None
                res += c + Fore.RESET
                continue
        elif status == "n":
            if c not in "0123456789e.":
                status = None
                res += Fore.RESET
        elif c == '"':
            status = '"'
            res += Fore.LIGHTCYAN_EX if ac else Fore.LIGHTGREEN_EX
        elif c in "0123456789":
            status = "n"
            res += Fore.LIGHTYELLOW_EX
        elif c in "{[":
            current_loop += 1
            res += colors[current_loop % 6] + c + Fore.RESET
            continue
        elif c in "}]":
            res += colors[current_loop % 6] + c + Fore.RESET
            current_loop -= 1
            continue
        elif c == "\n":
            status = None
            ac = False
            res += Fore.RESET
        elif status:
            pass
        elif c == ":":
            ac = True
            res += c + Fore.LIGHTMAGENTA_EX
            continue
        elif c == ",":
            ac = False
            res += Fore.RESET
        res += c
    res += Fore.RESET
    print(res)


main(
    # re.sub(
    #     "(null|true|false)",
    #     Fore.LIGHTMAGENTA_EX + r"\1" + Fore.RESET,
    json.dumps(data, indent=2, separators=(",", ": "), ensure_ascii=False),
    # )
)
