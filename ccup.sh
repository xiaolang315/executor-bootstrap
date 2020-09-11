#!/usr/bin/env bash

# export CCUP_CMD=$(cd "$(dirname "$0")"; pwd)

project="executor"
build="build"
docker_image="docker-hub.tools.huawei.com/bmc_dev/bmc_dev:v4"
deps_cache="./deps"

function help() {
    cat<<-EOF
Usage: ccup [OPTIONS]

Options:
    -e, Prepare environment
    -u, Update code and depends
    -b, Build project
    -r, Run executable
    -t, Execute testing
    -c, Clean the build
    -C, Clean the build and depends
    -h, The usage of ccup
EOF
}

function env() {
    docker pull $docker_image
    work_path=$(dirname $(readlink -f $0))
    echo $work_path
    docker run -it $work_path:/$project --user $(id -u):$(id -g) -w /$project $docker_image /bin/bash
}

function update() {
    echo "---------------------------------------"
    echo "Start to update project ${project}"
    git pull
    echo "---------------------------------------"
    echo "SUCCESS!"
}

function build() {
    export GIT_SSL_NO_VERIFY=1

    cmake -H. -B$build -DENABLE_TEST=on -DCPM_SOURCE_CACHE=$deps_cache
    cmake --build $build

    if [$? -ne 0]; then
        echo "FAILED!"
        exit 1
    fi
}

function run() {
    ./$build/src/${project}_service

    if [$? -ne 0]; then
        echo "FAILED!"
        exit 1
    fi    
}

function test() {
    ./$build/test/${project}_test

    if [$? -ne 0]; then
        echo "FAILED!"
        exit 1
    fi   
}

function clean() {
    rm -rf build/*
}

function clean_all() {
    rm -rf build/*
    rm -rf deps/*
}

function parse_args() {
    while getopts ':cCbrteuh' OPTS; do
        case $OPTS in
            e) env ;;
            u) update; ;;
            b) build; ;;
            r) run; ;;
            t) test; ;;
            c) clean; ;;
            C) clean_all; ;;
            h) help; ;;
            *) help;;
        esac
    done
}

function main() {
    parse_args "$@"
}

main "$@"


