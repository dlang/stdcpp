#!/bin/bash

set -e -o pipefail

if [ -z ${CXX+x} ]; then
    echo "Variable CXX is not set but is required for testing"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Expected one and only one argument for this script"
    exit 1
fi

EXTRAS_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

$CXX -c ${EXTRAS_DIR}/$1.cpp -o ${EXTRAS_DIR}/$1.o
