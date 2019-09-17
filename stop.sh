vt=$1
pid=$(ps a | grep tty$vt | grep Xorg | awk '{print $1;}')

docker stop PORTAL_$1
kill $pid
