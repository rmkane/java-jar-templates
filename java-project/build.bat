@echo off
setlocal EnableDelayedExpansion

set PROJECT_NAME=sample-java-project
set VERSION=1.0-SNAPSHOT

set "ROOT_DIR=%cd%"

set SRC_DIR=src
set RESOURCES_DIR=resources
set LIB_DIR=lib
set BUILD_DIR=build
set JAR_DIR=%BUILD_DIR%\jar
set CLASSES_DIR=%BUILD_DIR%\classes
set MAIN_CLASS=oata.HelloWorld
set MANIFEST=MANIFEST.MF

REM Clean task
if exist %BUILD_DIR%\ (
  echo Cleaning...
  rmdir /s /q %BUILD_DIR%\
)

REM Compile task
echo Compiling...
mkdir %CLASSES_DIR%

set __CLASSPATH=
for /r %ROOT_DIR%\%LIB_DIR% %%f in (*.*) do (
  if [%%~xf] == [.jar] (
    echo %%f
    set __CLASSPATH=!__CLASSPATH!;%LIB_DIR%/%%~nf%%~xf
  )
)
set CLASSPATH=%__CLASSPATH:~1%

REM TODO :- Generate source file list...
javac -sourcepath %SRC_DIR% -d %CLASSES_DIR% ^
  -cp %CLASSPATH% ^
  src/oata/HelloWorld.java src/oata/math/Adder.java

REM Jar task
echo Jarring...
mkdir %JAR_DIR%
echo Main-Class: %MAIN_CLASS%>%MANIFEST%
cp %RESOURCES_DIR%/*.xml %CLASSES_DIR%
jar -cfmv %JAR_DIR%/original-%PROJECT_NAME%-%VERSION%.jar %MANIFEST% -C %CLASSES_DIR% .
cp %LIB_DIR%/*.jar %CLASSES_DIR%
cd %CLASSES_DIR%
for /r %ROOT_DIR%\%CLASSES_DIR% %%f in (*.*) do (
  if [%%~xf] == [.jar] (
    jar xf %%f
    rm %%f
  )
)
cd %ROOT_DIR%
jar -cfmv %JAR_DIR%/%PROJECT_NAME%-%VERSION%.jar %MANIFEST% -C %CLASSES_DIR% .
del %MANIFEST%
cd %CLASSES_DIR%
del *.xml
cd %ROOT_DIR%
