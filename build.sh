#!/bin/bash

build="build"
project="executor"

echo "*******************************************************************************"
echo "start to build project ..."

cmake -H. -B$build -DENABLE_TEST=on -DCPM_SOURCE_CACHE=./deps
# cmake --build $build --target cpm-update-package-lock
cmake --build $build

if [ $? -ne 0 ]; then
    echo "FAILED!"
    cd ..
    exit 1
fi

echo "*******************************************************************************"
echo "start to run tests..."

./$build/test/${project}_test

if [ $? -ne 0 ]; then
    echo "FAILED!"
    cd ..
    exit 1
fi

echo "*******************************************************************************"
echo "SUCCESS!"
exit 0
