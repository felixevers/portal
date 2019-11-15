
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
  docker pull "$DOCKERIMAGE"
else
  #docker images
  echo "please enter the requested docker image:"
  read  INPUT; echo; echo
  DOCKERIMAGE=$INPUT
fi

if [ $DOCKERIMAGE == "" ]; then
  echo "No valid docker image given ... exiting"
  exit 1
elif [[ "$(docker images -q $DOCKERIMAGE 2> /dev/null)" == "" ]]; then
  echo "Could not find this docker image: $DOCKERIMAGE ... exiting"
  exit 1
else
  echo echo "Found docker image"
fi

echo "Installing packages ..."

if [ $DISTRO = "ARCH" ]; then
  pacman -Sy
  pacman -S lightdm  lightdm-webkit2-greeter
elif [ $DISTRO = "DEBIAN" ]; then
  apt-get install lightdm lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-webkit-theme-aether
else
  echo "Could not find apt or pacman this distribution or package manager is not supported"
  exit 1
fi

echo "Installing scripts ..."

mkdir /etc/portal
cp ./start.sh /etc/portal/
cp ./stop.sh /etc/portal
touch /etc/portal/start_script.sh
#echo "/etc/portal/start.sh $DOCKERIMAGE" > /etc/portal/start_script.sh
echo "touch home/$USER/hereiam" > /etc/portal/start_script.sh

echo "Configurating Lightdm ..."

echo "session-setup-script=/etc/portal/start_script.sh" >> /etc/lightdm/lightdm.conf

echo "Enables Lightdm daemon ..."
systemctl enable lightdm.service
