#!/bin/sh
make -C build
which performance && performance
if [ -z "$@" ]; then
    test -f log.speed && mv log.speed log.speed.bak
    (for g in `./SMHasher --listnames`; do
         ./SMHasher --test=Speed,Hashmap $g 2>&1; done) | tee log.speed
    ./speed.pl && \
        ./fixupdocspeeds.pl
else
     (for g in `./SMHasher --listnames | egrep "$@"`; do
         ./SMHasher --test=Speed,Hashmap $g 2>&1; done) | tee "log.speed-$1"
    ./speed.pl "log.speed-$1" && \
        ./fixupdocspeeds.pl "log.speed-$1"
fi
