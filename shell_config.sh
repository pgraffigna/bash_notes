## oh-my-bash en Ubuntu 20.04
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# tema para oh-my-bash 
# editar la linea en .bashrc
OSH_THEME="powerline"

-------------------
## powerline-go en Ubuntu 18.04
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update && sudo apt install -y golang-go
go get -u github.com/justjanne/powerline-go

# agregar esto en ~/.bashrc

GOPATH=$HOME/go
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $?)"
}
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

------------------------
## oh-my-posh en Powershell
Install-Module posh-git -Scope CurrentUser --> si usas git en Windows
Install-Module oh-my-posh -Scope CurrentUser

# ejecutar "notepad $PROFILE" y agregar estas lineas:
Import-Module posh-git --> si usas git en Windows
Import-Module oh-my-posh
Set-PoshPrompt -Theme Paradox

# Instalar las fuentes "Cascadia Code PL" para todos los usuarios
https://github.com/microsoft/cascadia-code/releases/tag/v2102.25

# Editar setting.json en Windows Terminal

"profiles":
    	{
        "defaults": {
		"fontFace": "Cascadia Code PL",
	        "fontSize": 11
	},
}
