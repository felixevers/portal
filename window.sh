IMAGE=useto/portal

LAST_DISPLAY=$(ls /tmp/.X11-unix/ | sort | tail -n 1 | tail -c +2 | head -c -1)
NEW_DISPLAY=$((LAST_DISPLAY+1))

Xephyr -br -ac -reset -terminate -screen 1920x1054 :$NEW_DISPLAY &

docker run \
    --name portal_window_$NEW_DISPLAY \
    -e DISPLAY=:$NEW_DISPLAY \
    -v /tmp/.X11-unix/X$NEW_DISPLAY:/tmp/.X11-unix/X$NEW_DISPLAY:rw \
    --rm \
    --net=host \
    --ipc=host \
    --privileged \
    -v /etc/localtime:/etc/localtime:ro \
    -d \
    $IMAGE > /dev/null
