LAST_DISPLAY=$(ls /tmp/.X11-unix/ | sort | tail -n 1 | tail -c +2 | head -c -1)
DISPLAY=$((LAST_DISPLAY+1))
vt=$2

mkdir -p ~/portal_data
chown -R 1000:1000 ~/portal_data

Xorg -configure
Xorg :$DISPLAY vt$vt \
  -dpms -s off -retro \
  +extension RANDR \
  +extension RENDER \
  +extension GLX \
  +extension XVideo \
  +extension DOUBLE-BUFFER \
  +extension SECURITY \
  +extension DAMAGE \
  -extension X-Resource \
  -extension XINERAMA -xinerama \
  -extension MIT-SHM \
  -nolisten tcp \
  +extension Composite +extension COMPOSITE \
  -extension XTEST -tst \
  -dpi 96 \
  -verbose \
  -quiet &

docker run \
    --name PORTAL_$vt \
    -e DISPLAY=:$DISPLAY \
    -v /tmp/.X11-unix/X$DISPLAY:/tmp/.X11-unix/X$DISPLAY:rw \
    --rm \
    -v ${PWD}/run:/home/worker/.run:ro \
    -v ~/portal_data:/home/worker/data:rw \
    -v /dev:/dev \
    --ipc=host \
    --privileged \
    -d \
    $1
