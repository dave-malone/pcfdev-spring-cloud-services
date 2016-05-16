#!/bin/bash

source ./setup.sh
mkdir $LOG_DIR

unzip p-spring-cloud-services-*.zip -d $SCS_HOME
mkdir -p $SCS_BROKER_RELEASE
tar -zxvf $SCS_RELEASES/spring-cloud-broker*.tgz -C $SCS_BROKER_RELEASE
mkdir -p $SCS_BROKER
tar -zxvf $SCS_BROKER_PACKAGES/spring-cloud-service-broker.tgz -C $SCS_BROKER

cd $SCS_BROKER

echo '-------------------------------------------------------'
echo '           Config Tile Environment                     '
source scripts/configureTileEnvironment.sh
echo '-------------------------------------------------------'
echo '            Deploy Broker Worker                       '
source $START_DIR/deployBrokerWorker.sh
echo '-------------------------------------------------------'
echo '           Register Service Broker                     '
chmod +x scripts/registerServiceBroker.sh
eval scripts/registerServiceBroker.sh
echo '-------------------------------------------------------'

cd $START_DIR
