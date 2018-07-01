#!/bin/bash

#exit script if any command fails (non-zero value)
set -e

cd resources
cp mysql-connector-java-5.1.46-bin.jar ../lib/
cd ../

echo 'Drivers copied!'
echo ''
echo 'Running transformation!'

#run a transformation (get db credentials)
./pan.sh -file=resources/Read-DBs.ktr

#run a transformation (does the db exist)
./pan.sh -file=resources/GoldBi-Exists.ktr

#redirect input variables
exec "$@"
