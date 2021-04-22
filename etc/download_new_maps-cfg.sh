#!/bin/bash
cd ./tf/maps
while read mapname
do
    if [[ $mapname != http* ]]
    then
        mapname="https://dl.serveme.tf/maps/$mapname"
    fi

    wget $mapname
    
    if [[ $mapname == *.bz2 ]]
    then
        bunzip2 -f $(basename $mapname)
        rm -f $(basename $mapname)
    fi
done < /maps.txt

cd ../cfg

while read cfgname
do
    wget $cfgname
    
    if [[ $cfgname == *.zip ]]
    then
        mkdir extracted_files
        unzip -o -d extracted_files $(basename $cfgname)
        find extracted_files/ -type f -name "*.cfg" -exec mv -t . {} +
        rm -rf extracted_files $(basename $cfgname)
    fi
done < /cfgs.txt

cd ../../
