#!/bin/bash

target="build"

echo "*******************************************************************************"
echo "start to build project ..."

cmake -H. -B$target -DENABLE_TEST=on -DCPM_SOURCE_CACHE=./deps
# cmake --build $target --target cpm-update-package-lock
cmake --build $target

if [ $? -ne 0 ]; then
    echo "FAILED!"
    cd ..
    exit 1
fi

echo "*******************************************************************************"
echo "start to run tests..."

./$target/test/executor_test

if [ $? -ne 0 ]; then
    echo "FAILED!"
    cd ..
    exit 1
fi

echo "*******************************************************************************"
echo "SUCCESS!"
exit 0
