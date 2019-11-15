

clear
echo "--------------------------------------------------"
echo " Portal Lightdm Setup"
echo "--------------------------------------------------"

DISTRO=false
if type "pacman" > /dev/null 2>&1; then
  DISTRO="ARCH"
elif type "apt" > /dev/null 2>&1; then
  DISTRO="DEBIAN"

echo "You are running GNU / LINUX - $DISTRO"

DOCKERIMAGE = $1

if [$DOCKERIMAGE == ""]; then
  echo "No valid docker image given ... exiting"
  return 1

elif [docker images | grep $DOCKERIMAGE == ""]; then
  echo "Could not find this docker image: $DOCKERIMAGE ... exiting"
  return 1

echo "Installing packages ..."

if [$DISTRO = "ARCH"]; then
  pacman -S lightdm  lightdm-webkit2-greeter
elif [$DISTRO = "DEBIAN"]; then
  apt-get install lightdm lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-webkit-theme-aether

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





