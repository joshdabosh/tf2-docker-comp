#!/bin/bash
cd ./tf/addons/sourcemod/plugins/
while read plugindl
do
    wget $plugindl
done < /plugins.txt

chmod u+rx *

cd ../../../../