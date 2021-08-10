#!/usr/bin/python3

import sys, socket

host = input("Ingresa la IP del Host a escanear: ")
port = int(input("Ingresa el PUERTO a escanear: "))

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

def tcp_scanner(port):
	if s.connect_ex ((host, port)):
		print("El puerto esta cerrado")
	else:
		print("El puerto esta abierto")

if __name__ == '__main__':

	tcp_scanner(port)
