
# exit when any command fails
set -e

clear
echo "--------------------------------------------------"
echo " Portal Lightdm Setup"
echo "--------------------------------------------------"

DISTRO=false
if type "pacman" > /dev/null 2>&1; then
  DISTRO="ARCH"
elif type "apt" > /dev/null 2>&1; then
  DISTRO="DEBIAN"
else
  echo "Not supported distribution"
  exit 1
fi

echo "You are running GNU / LINUX - $DISTRO"

echo "Do you want to run the default image (y/N)"
read -n 1 INPUT ; echo; echo

DOCKERIMAGE=false
if [ $INPUT == "y" ] || [ $INPUT == "Y" ]; then
  DOCKERIMAGE="use-to/portal"
  sudo docker pull "$DOCKERIMAGE"
else
  #docker images
  echo "please enter the requested docker image:"
  read  INPUT; echo; echo
  DOCKERIMAGE=$INPUT
fi

if [ $DOCKERIMAGE == "" ]; then
  echo "No valid docker image given ... exiting"
  exit 1
elif [[ "$(sudo docker images -q $DOCKERIMAGE 2> /dev/null)" == "" ]]; then
  echo "Could not find this docker image: $DOCKERIMAGE ... exiting"
  exit 1
else
  echo echo "Found docker image"
fi

echo "Installing packages ..."

if [ $DISTRO = "ARCH" ]; then
  sudo pacman -Sy
  sudo pacman -S lightdm  lightdm-webkit2-greeter lightdm-gtk-greeter
  git clone https://aur.archlinux.org/lightdm-webkit-theme-aether.git
  cd lightdm-webkit-theme-aether && makepkg -si && cd ..

elif [ $DISTRO = "DEBIAN" ]; then
  sudo apt-get install lightdm lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-webkit-theme-aether
else
  echo "Could not find apt or pacman this distribution or package manager is not supported"
  exit 1
fi

echo "Installing scripts ..."

if [ ! -d "/etc/portal"]; then
  sudo mkdir /etc/portal
  sudo rm /etc/portal/start_script.sh
  sudo touch /etc/portal/start_script.sh
fi

sudo cp ./start.sh /etc/portal/
sudo cp ./stop.sh /etc/portal

#echo "/etc/portal/start.sh $DOCKERIMAGE" > /etc/portal/start_script.sh
sudo sh -c 'echo "touch home/$USER/hereiam" > /etc/portal/start_script.sh'

echo "Configurating Lightdm ..."

sudo sh -c 'echo "session-setup-script=/etc/portal/start_script.sh" >> /etc/lightdm/lightdm.conf'
sudo sh -c 'echo "greeter-session=lightdm-webkit2-greeter" >> /etc/lightdm/lightdm.conf'
sudo sh -c 'echo "theme=aether" >> /etc/lightdm/lightdm.conf'

echo "Enables Lightdm daemon ..."
sudo systemctl enable lightdm.service
