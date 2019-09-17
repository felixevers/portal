vt=$1
pid=$(cat ~/.cache/portal/PORTAL_$1)

docker stop PORTAL_$1
kill $pid
