#!/bin/bash

# requires NodeJS, httypyac, pip, Python, and junit2htmlreport
# npm install -g httpyac
# pip install junit2htmlreport

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
SRC_DIR=$(readlink -f $SCRIPT_DIR/../../../../../../../assurance/1115-waiver/ahc-hrsn/screening/regression-test-prime/fhir-service-prime/src)
TIMESTAMP=$(date +'%Y/%m/%Y-%m-%d-%H-%M-%S')
RESULTS_DIR=$SCRIPT_DIR/results
LATEST_RESULTS_DIR=$RESULTS_DIR/$TIMESTAMP
LATEST_RESULTS_SYMLINK=$RESULTS_DIR/latest

mkdir -p $LATEST_RESULTS_DIR

echo $SCRIPT_DIR
echo $SRC_DIR
echo $TIMESTAMP
echo $RESULTS_DIR
echo $LATEST_RESULTS_DIR
echo $LATEST_RESULTS_SYMLINK

httpyac $SRC_DIR/fhir-service.test.http --all > $LATEST_RESULTS_DIR/regression-test-results.httpyac.txt
httpyac $SRC_DIR/fhir-service.test.http --all --junit > $LATEST_RESULTS_DIR/regression-test-results.httpyac.junit.xml
python -m junit2htmlreport $LATEST_RESULTS_DIR/regression-test-results.httpyac.junit.xml $LATEST_RESULTS_DIR/regression-test-results.httpyac.junit.xml.html

rm -f $LATEST_RESULTS_SYMLINK
ln -s $LATEST_RESULTS_DIR $LATEST_RESULTS_SYMLINK