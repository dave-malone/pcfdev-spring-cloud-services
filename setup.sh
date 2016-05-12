#!/bin/bash

#setup env for extracting scs
export START_DIR="$PWD"

export SCS_HOME=./scs
export SCS_RELEASES=$SCS_HOME/releases
export SCS_BROKER_RELEASE=$SCS_RELEASES/scs-broker-release
export SCS_BROKER_PACKAGES=$SCS_BROKER_RELEASE/packages
export SCS_BROKER=$SCS_BROKER_PACKAGES/scs-broker


#setup env required to deploy SCS
export LOG_DIR=$START_DIR/scs-install-logs
export SYSTEM_DOMAIN='local.pcfdev.io'
export APP_DOMAIN='local.pcfdev.io'
export ADMIN_USER='admin'
export ADMIN_PASSWORD='admin'
export SKIP_CERT_VERIFY='true'
export PRODUCT_NAME='spring-cloud-services'
export ADMIN_CLIENT_ID='admin'
export ADMIN_CLIENT_SECRET='admin-client-secret'
export BROKER_CLIENT_SECRET='brokersecret'
export WORKER_CLIENT_ID='workerclient'
export WORKER_CLIENT_SECRET='workersecret'
export WORKER_USER_NAME='scsworker'
export WORKER_USER_PASSWORD='scsworkerpassword'
#this variable is misleading; this seems to be the URI for the UAA instance
export APP_URI='scsbroker'
export INSTANCES_ORG='scs'
export INSTANCES_SPACE='instances'
export BROKER_ORG='scs'
export BROKER_SPACE='broker'
export BROKER_APP_NAME='scs-broker'
export BROKER_HOST=$BROKER_APP_NAME'.'$APP_DOMAIN
export BROKER_MAX_INSTANCES='1'
export BROKER_USER_NAME='scsbroker'
export BROKER_USER_PASSWORD='scsbrokerpassword'
export BROKER_VERSION='1'
export BROKER_WORKER_VERSION='1'
export PERSISTENCE_STORE_TYPE='mysql'
export MESSAGE_BUS_TYPE='rabbitmq'
export INSTANCES_SPACE_USER='scsinstancesuser'
export INSTANCES_SPACE_USER_PASSWORD='scsinstancespassword'
export PACKAGE_PATH=./spring-cloud-service-broker
export APP_PUSH_TIMEOUT='180'
export APP_PUSH_MEMORY='1024M'
export SECURITY_USER_NAME='scssecurityuser'
export SECURITY_USER_PASSWORD='scssecuritypassword'

export CF_TARGET=http://api.$SYSTEM_DOMAIN
