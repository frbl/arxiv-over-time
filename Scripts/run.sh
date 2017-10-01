#!/usr/bin/env sh
for folder in */; do
  echo "Executing $folder"
  cd $folder
  ./run.sh
  cd -
done
