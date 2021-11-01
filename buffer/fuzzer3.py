#!/usr/bin/python3
# coding: utf-8

import socket, signal, sys, time
from pwn import *

def def_handler(sig, frame):
    print("Saliendo del programa!!...\n")
    sys.exit(1)

signal.signal(signal.SIGINT, def_handler)

if len(sys.argv) < 3:
    print("[!] Modo de uso: python3 " + sys.argv[0] + " <ip-address> <puerto>\n")
    sys.exit(1)

ip_addr = sys.argv[1]
port = sys.argv[2]

if __name__ == '__main__':

	buffer = ["A"]
	counter = 50

	while len(buffer) <= 30:
		buffer.append("A" * counter)
		counter += 100

	p1 = log.progress("Fuzzeando")

	for strings in buffer:
		p1.status("Enviando %s bytes" %len(strings))
		time.sleep(2)
		try:
		  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		  s.connect((ip_addr, int(port)))
		  s.recv(1024)
		  s.send(bytes(strings + "\r\n", "latin-1"))
		except:
		  print("Error en la conexiòn")
		  sys.exit(1)

