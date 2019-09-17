vt=$1
pid=$(ps -C Xorg | grep tty$vt | awk '{print $1;}')

docker stop PORTAL_$1
kill $pid
