#!/usr/bin/python3

import sys, socket, threading

host = input("Ingrese la IP del equipo a escanear: ")

def tcp_scanner(port):
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

	try:
		res = s.connect_ex((host, port))
		if res == 0:
			print("El puerto {} esta abierto".format(port))
			s.close()
		else:
			print("El puerto {} esta cerrado".format(port))

	except socket.error:
		print("No se pudo conectar con el servidor")
		sys.exit()

	except KeyboardInterrupt:
		print("Saliendo del programa..")
		sys.exit()

if __name__ == '__main__':
		for port in range(20,100):
			tcp_scanner(port)

t = threading.Thread(target=tcp_scanner, args=(port,))
t.start()

