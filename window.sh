IMAGE=portal
RESOLUTION=1920x1080

LAST_DISPLAY=$(ls /tmp/.X11-unix/ | sort | tail -n 1 | tail -c +2 | head -c -1)
NEW_DISPLAY=$((LAST_DISPLAY+1))

Xephyr -br -ac -reset -terminate -keybd ephyr,,,xkbmodel=pc105,xkblayout=de -screen $RESOLUTION :$NEW_DISPLAY 2> /dev/null &  

mkdir -p ~/portal_data
chown -R 1000:1000 ~/portal_data

docker run \
    --name portal_window_$NEW_DISPLAY \
    --hostname portal \
    -e DISPLAY=:$NEW_DISPLAY \
    -v /tmp/.X11-unix/X$NEW_DISPLAY:/tmp/.X11-unix/X$NEW_DISPLAY:rw \
    --device /dev/snd \
    -v ~/portal_data:/home/worker/data:rw \
    --rm \
    --ipc=host \
    --privileged \
    -v /etc/localtime:/etc/localtime:ro \
    -d \
    $IMAGE > /dev/null
