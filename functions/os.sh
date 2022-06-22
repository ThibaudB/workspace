#!/bin/sh
export os = function () {
  unameOut=$(uname -a)
  case "${unameOut}" in
    *microsoft*) OS="WSL2";; #must be first since Windows subsystem for linux will have Linux in the name too
    Linux*)      OS="Linux";;
    Darwin*)     OS="Mac";;
    CYGWIN*)     OS="Cygwin";;
    MINGW*)      OS="Windows";;
    *Msys)       OS="Windows";;
    *)           OS="UNKNOWN:${unameOut}"
  esac
  
  echo ${OS};
}
