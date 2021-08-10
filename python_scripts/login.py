#!/usr/bin/python3

import requests, sys, time
from pwn import *

main_url = "https://mail.cultura.gob.ar/"

def makeRequest():

	p1 = log.progress("Fase1")
	p1.status("Analizando")
	time.sleep(3)

	post_data = {
		'loginOp': 'login',
		'username': 'USUARIO',
		'password': 'PASSWORD'
	}

	p1.status("Enviando datos al sistema")

	r = requests.post(main_url, data=post_data)
	print(r.text)

	p1.success("Entramos!!")

if __name__ == '__main__':

	makeRequest()
