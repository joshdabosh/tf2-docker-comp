#!/bin/bash
cd ./tf/maps
while read mapname
do
    if [[ $mapname != http* ]]
    then
        mapname="https://dl.serveme.tf/maps/$mapname"
    fi

    wget -q $mapname
    
    if [[ $mapname == *.bz2 ]]
    then
        bunzip2 $(basename $mapname)
        rm -f $(basename $mapname)
    fi
done < ../../default_maps.txt
