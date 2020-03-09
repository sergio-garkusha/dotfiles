#!/usr/bin/env python3
# saved to ~/bin/batcharge.py

import subprocess

# Get battery info using acpi (apt install acpi)
charge = subprocess.check_output(["acpi", "-b"], stderr=subprocess.DEVNULL)

# If power supply device does not exist, exit
if not charge:
    exit(0)


import math, sys

class bcolors:
    HEADER = "\033[95m"
    OKBLUE = "\033[94m"
    OKGREEN = "\033[92m"
    WARNING = "\033[93m"
    FAIL = "\033[91m"
    ENDC = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"

# full_char  = u"▱"
# empty_char = u"▰"
# full_char  = u"◼"
# empty_char = u"◻"
# full_char  = u"⦿"
# empty_char = u"⊙"
# full_char  = u"◉"
# empty_char = u"○"
# full_char  = u"●"
# empty_char = u"○"
# full_char  = u"◈"
# empty_char = u"◇"
# full_char  = u"◉"
# empty_char = u"◎"
# full_char  = u"✪"
# empty_char = u"✩"
full_char  = u"⦿"
empty_char = u"⚆"

# Get % of battery charge
charge = int(charge.split(", ")[1].replace("%", "")) / 10.0

# Output
total_slots, slots = 10, []
filled = int(math.ceil(charge * (total_slots / 10.0))) * full_char
empty = (total_slots - len(filled)) * empty_char

out = (filled + empty).encode("utf-8")

color_out = (
    bcolors.OKGREEN if len(filled) > 6
    else bcolors.WARNING if len(filled) > 4
    else bcolors.FAIL
)

out = color_out + out
sys.stdout.write(out)
