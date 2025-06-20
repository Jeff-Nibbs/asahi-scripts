#!/usr/bin/env python3

import base64

def encode(password):
    encoded_password = base64.b64encode(password.encode())
    return encoded_password

def decode(password):
    decoded_password = base64.b64decode(password).decode()
    return decoded_password

direction = input("Press (E)ncode or (D)ecode: ").lower()

if direction == "d":
    to_be_swaped = input("Add charaters here: ")
    ans = decode(to_be_swaped)
    print(ans)
elif direction == "e":
    to_be_swaped = input("Add charaters here: ")
    ans = encode(to_be_swaped)
    print(ans)
else:
    print("Hey just put 'e' or 'd' like its not that hard. What are you doing. What did you have to put in to get this screen. Do you have a drivers licence. How did you pass that test if you can't even follow these simple instructions. Its truly a mericle you are alive at all.")
