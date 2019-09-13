FROM useto/portal:latest

RUN sudo pacman -Syu --noconfirm
RUN sudo pacman -Sy --noconfirm
RUN sudo pacman -S openssh wireshark-qt texlive-most python python-pip jre-openjdk jdk-openjdk php nodejs npm texstudio openvpn bridge-utils easy-rsa discord maven gdb gcc clang nmap netcat arp-scan --noconfirm

RUN sudo pip install requests scapy beautifulsoup4 numpy scipy matplotlib plotly pipenv tensorflow flask jupyter pandas sqlalchemy pymysql

RUN sudo npm install -g @angular/cli ionic

RUN sudo -u worker bash -c "yay -Sy intellij-idea-ultimate-edition pycharm-professional android-studio android-sdk typora --noconfirm --nopgpfetch"

CMD /usr/bin/i3
