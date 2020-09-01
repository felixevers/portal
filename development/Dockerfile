FROM useto/portal:latest

RUN sudo pacman -Syu --noconfirm
RUN sudo pacman -Sy --noconfirm
RUN sudo pacman -S openssh wireshark-qt texlive-most python python-pip jre-openjdk jdk-openjdk php composer nodejs npm openvpn bridge-utils easy-rsa maven gdb gcc clang nmap netcat arp-scan --noconfirm

RUN sudo pip install requests scapy beautifulsoup4 numpy scipy matplotlib plotly pipenv tensorflow flask jupyter pandas sqlalchemy pymysql flake8 isort yapf autoflake coverage
RUN sudo npm install -g @angular/cli ionic typescript-formatter tslint eslint-cli
RUN sudo composer require --dev vimeo/psalm

RUN curl -sLf https://spacevim.org/install.sh | bash
RUN nvim --headless +'call dein#install()' +qall

CMD /usr/bin/i3
