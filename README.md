# bash_notes

#############################################
# Funciones -- agregar al archivo ~/.bashrc #	
############################################# 

# consulta la ip pública
myip(){ 
  curl -s ifconfig.me/all | grep ip_addr | awk '{print $2}'
}

# masscan arp mode hacia archivo
mscan(){ 
  sudo masscan ip/cidr --arp > FILE
}

# usa el archivo generado por la función mscan para resolver los nombres de host
mscanHOST(){
  for ips in $(cat FILE | awk '{print $6}');do host $ips; done
}

# chequeo de la configuración de nagios
check_nagios(){ 
  /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
}

# consulta la ip de los contenedores
dockip(){
  docker inspect -f "{{ .NetworkSettings.IPAddress }}" $1
}

# inicia una conexión VPN
vpn(){
  sudo openvpn FILE.ovpn
}

################################################
# Alias					       #	
# agregar los alias al archivo ~/.bash_aliases #
# sino existe crear                            #
# touch ~/.bash_aliases                        #
################################################

# muestra el nivel de batería
alias check_battery="upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | awk 'NF{print $NF}'"

##########################################
# Varios                                 #
##########################################

# Agrega la fecha a la salida del comando HISTORY
export HISTTIMEFORMAT="%d/%m/%y %T "

