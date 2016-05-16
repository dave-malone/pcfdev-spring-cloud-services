#!/bin/bash

source ./setup.sh

cf delete-org $BROKER_ORG -f

rm -rf $SCS_HOME
rm -rf $LOG_DIR
