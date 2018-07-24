import os
import stat

def perms_dangerous(path: str) -> bool:
    perm = os.stat(path).st_mode
    # I just implemented my first actually useful code using bitwise operators.
    # It is 23:49 at night and I am supposed to be on vacation.
    # Send help.
    return bool(perm & (stat.S_IRGRP | stat.S_IROTH))

print(perms_dangerous('/Users/boesen/.td.yml'))
