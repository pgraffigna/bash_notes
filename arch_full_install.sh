# instalación de archlinux en sistema UEFI
# boot
bootear desde la ISO -- tener en cuenta desactivar secure_boot

# teclado en español
loadkeys es

# crear particiones en disco
cfdisk /dev/disco

1 - particion 512M - Linux
2 - particion 250G - Linux
3 - particion 4G   - swap

## formato a las particiones
1 - mkfs.vfat -F 32 /dev/sda1
2 - mkfs.ext4 /dev/sda2
3 - mkswap /dev/sda3 
	swapon

## montamos las particiones
mount /dev/sda2 /mnt
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

# instalando paquetes base
pacstrap /mnt linux linux-firmware networkmanager grub wpa_supplicant base base-devel

# creando el fstab
genfstab -U /mnt > /mnt/etc/fstab

# creacion de usuarios
arch-chroot /mnt
passwd --> password para root

useradd -m pgraffigna
passwd pgraffigna
usermod -aG wheel pgraffigna

## dependencias
pacman -S nano vim sudo

## editar /etc/sudoers
editar linea %wheel

# editar /etc/locale.gen
descomentar en_US, es_ES
locale-gen

# teclado en español
editar /etc/vconsole.conf
KEYMAP=es

# grub install
pacman -S efibootmgr
grub-install /dev/sda
grub-mkdconfig -o /boot/efi/grub/grub.cfg

# hostname + hosts
echo nombre_equipo > /etc/hostname

nano /etc/hosts
127.0.0.1 localhost
::1 	  localhost
127.0.0.1 nombre_equipo.localhost nombre_equipo


# reiniciando
reboot
# habilitar conexion a internet
systemctl enable NetworkManager.service --now
systemctl enable wpa_supplicant.service --now

# dependencias
pacman -S git

mkdir -p /home/pgraffigna/Desktop/s4vitar/repos
cd Desktop/s4vitar/repos

# agregando repo aur
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si

# agregando repo blackarch
mkdir blackarch && cd
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh

pacman -Sy
pacman -Sgg | grep 'blackarch'

# interfaz grafica
pacman -S xorg xorg-server
pacman -S gnome
systemctl enable gdm.service --now

# dependencias
pacman -S kitty

# teclado en español via GUI

# awesome
github.com/rxyhn/dotfiles
paru -S awesome-git
paru -S "dependencies"
paru -S "services"

## awesome fonts
cd /usr/share/fonts

# iosevka
wget http://fontlot.com/downfile/5baeb08d06494fc84dbe36210f6f0ad5.105610

mv 5baeb08d06494fc84dbe36210f6f0ad5.105610 comprimido.zip
unzip comprimido.zip
rm comprimido.zip

find . | grep '.ttf$' | while read line; do cp $line .; done
rm -r iosevka-2.2.1/
rm -r iosevka-slab-2.2.1/

# icommon
descargar --> https://www.dropbox.com/s/hrkub2yo9iapljz/icomoon.zip?dl=0
mv /home/pgraffigna/downloads/icomoon.zip .
unzip icomoon.zip
mv icomoon/*.ttf .
rm -rf icomoon/

# fuentes varias
paru -S nerd-fonts-jetbrains-mono ttf-font-awesome ttf-font-awesome-4 ttf-material-design-icons

# config
git clone https://github.com/rxyhn/dotfiles.git
cd dotfiles

cp -r config/* ~/.config/
cp -r bin/* ~/.local/bin/
cp -r misc/. ~/

## fix error .local/bin
mkdir /home/pgraffigna/.local/bin

reboot now





# volver a commit anterior
cd /home/pgraffigna/repos/dotfiles
git checkout $(git log | grep 'commit c1e' | awk NF '{print $NF}')

cp -r config/* /home/pgraffigna/.config/
cp -r bin/* /home/pgraffigna/.local/bin
cp -r misc/ /home/pgraffigna

sudo reboot now

# tuneando
nano .config/awesome/rc.lua --> terminal = "kitty"

## zsh
pacman -S zsh
usermod --shell /usr/bin/zsh pgraffigna
localectl set-x11-keymap es

# zsh config s4vitar
copiar configuración de s4vitar en s4vitar.github.io --> "Archivo zshrc"

paru -S zsh-syntax-highlighting zsh-autosuggestions

# fix plugins
editar .zshrc

agregar en plugins:
/usr/share/zsh/plugins/zsh-sintax
/usr/share/zsh/plugins/zsh-autosuggestions

cd /usr/share
mkdir zsh-sudo
chown -R pgraffigna:pgraffigna zsh-sudo
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

pacman -S lsd bat

# mas fuentes
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip -o /usr/share/fonts/Hack.zip
unzip Hack.zip
rm Hack.zip

# config kitty
nano /home/pgraffigna/.config/kitty/kitty.conf
nano /home/pgraffigna/.config/kitty/color.ini

pegar el contenido del repo --> https://raw.github.com/rxyhn/bspdots/tree/main/config/kitty/kitty.conf
pegar el contenido del repo --> https://raw.githubusercontent.com/rxyhn/bspdots/main/config/kitty/color.ini

# configuraciones restantes
https://www.youtube.com/watch?v=fshLf6u8B-w&t=3596s


