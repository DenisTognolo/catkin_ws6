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
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/denis/catkin_ws6/src/src/universal_robot/ur_driver"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/denis/catkin_ws6/src/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/denis/catkin_ws6/src/install/lib/python3/dist-packages:/home/denis/catkin_ws6/src/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/denis/catkin_ws6/src/build" \
    "/usr/bin/python3" \
    "/home/denis/catkin_ws6/src/src/universal_robot/ur_driver/setup.py" \
     \
    build --build-base "/home/denis/catkin_ws6/src/build/universal_robot/ur_driver" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/denis/catkin_ws6/src/install" --install-scripts="/home/denis/catkin_ws6/src/install/bin"