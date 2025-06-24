import sys
sys.setrecursionlimit(1500)  # Optional to avoid recursion limit errors

import os
os.environ['PYTHONUSERBASE'] = '/home/mrmans/.local'
os.environ['ENABLE_USER_SITE'] = 'True'

import socket




sniffer_socket = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.ntohs(3))
interface = "eth0"
sniffer_socket.bind((interface, 0))

try:
    while True:
        raw_data, addr = sniffer_socket.recvfrom(65565)
        packet = Ether(raw_data)
        print(packet.summary())

except KeyboardInterrupt:
    sniffer_socket.close()


