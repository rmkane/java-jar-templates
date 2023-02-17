#!/bin/bash

PROJECT_NAME=sample-java-project
VERSION=1.0-SNAPSHOT

ROOT_DIR=$(pwd)

SRC_DIR=src
RESOURCES_DIR=resources
LIB_DIR=lib
BUILD_DIR=build
JAR_DIR=$BUILD_DIR/jar
CLASSES_DIR=$BUILD_DIR/classes
MAIN_CLASS=oata.HelloWorld
MANIFEST=MANIFEST.MF

function get_source_files {
    CURR_DIR=$(pwd)
    cd $ROOT_DIR
    local __file_list=""
    while read fname; do
        __file_list="$__file_list ${fname}"
    done <<< "$(find $SRC_DIR -type f -name "*.java")"
    cd $CURR_DIR
    echo "${__file_list:1}"
}

function get_classpath {
    CURR_DIR=$(pwd)
    cd $ROOT_DIR
    local __classpath=""
    cd $LIB_DIR
    for jar_file in $ROOT_DIR/$LIB_DIR/*.jar
    do
        __base_name=$(basename $jar_file)
        __classpath="$__classpath;$LIB_DIR/$__base_name"
    done
    cd $CURR_DIR
    echo "${__classpath:1}"
}

function task_clean {
    rm -rf $BUILD_DIR
}

function task_compile {
    __cp=$(get_classpath)
    __sources=$(get_source_files)
    mkdir -p $CLASSES_DIR
    javac -sourcepath $SRC_DIR -d $CLASSES_DIR -cp $__cp $__sources
}

function task_jar {
    task_compile
    mkdir -p $JAR_DIR
    echo Main-Class: $MAIN_CLASS>$MANIFEST
    cp $RESOURCES_DIR/*.xml $CLASSES_DIR
    jar -cfmv $JAR_DIR/original-$PROJECT_NAME-$VERSION.jar $MANIFEST -C $CLASSES_DIR .
    cp $LIB_DIR/*.jar $CLASSES_DIR
    cd $CLASSES_DIR
    for jar_file in $ROOT_DIR/$CLASSES_DIR/*.jar
    do
        jar xf $jar_file
        rm $jar_file
    done
    cd $ROOT_DIR
    jar -cfmv $JAR_DIR/$PROJECT_NAME-$VERSION.jar $MANIFEST -C $CLASSES_DIR .
    rm $MANIFEST
    rm $CLASSES_DIR/*.xml
}

function task_build {
    task_clean
    task_jar
}

if [ $# -eq 0 ]; then
    task_build
    exit 0
fi

if [ $1 == "clean" ]; then
    task_clean
elif [ $1 == "compile" ]; then
    task_compile
elif [ $1 == "jar" ]; then
    task_jar
elif [ $1 == "build" ]; then
    task_build
else
    echo "Unknown command"
fi

exit 0
