#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/roktober/last/src/wheel_module"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/roktober/last/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/roktober/last/install/lib/python3/dist-packages:/home/roktober/last/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/roktober/last/build" \
    "/home/roktober/anaconda3/bin/python" \
    "/home/roktober/last/src/wheel_module/setup.py" \
    build --build-base "/home/roktober/last/build/wheel_module" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/roktober/last/install" --install-scripts="/home/roktober/last/install/bin"
