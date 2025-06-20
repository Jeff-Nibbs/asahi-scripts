#!/usr/bin/env python3

import base64

def encode(password):
    encoded_password = base64.b64encode(password.encode())
    return encoded_password

to_be_encoded = input("Add password here: ")
ans = encode(to_be_encoded)
print(ans)
