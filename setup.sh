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
export SYSTEM_DOMAIN=local.pcfdev.io
export APP_DOMAIN=local.pcfdev.io
export ADMIN_USER=admin
export ADMIN_PASSWORD=admin
export PRODUCT_NAME=spring-cloud-services
export ADMIN_CLIENT_ID=admin
export ADMIN_CLIENT_SECRET=admin-client-secret

export BROKER_CLIENT_SECRET=brokersecret
export WORKER_CLIENT_ID=workerclient
export WORKER_CLIENT_SECRET=workersecret
export WORKER_USER_NAME=$ADMIN_USER
export WORKER_USER_PASSWORD=$ADMIN_PASSWORD
#this variable is misleading; this seems to be the URI for the UAA instance
export APP_URI=scsbroker
export INSTANCES_ORG=system
export INSTANCES_SPACE=p-spring-cloud-services
export BROKER_ORG=system
export BROKER_SPACE=p-spring-cloud-services
export BROKER_APP_NAME=scsbroker
export BROKER_HOST=https://$BROKER_APP_NAME.$APP_DOMAIN
export BROKER_MAX_INSTANCES=100
export BROKER_USER_NAME=$ADMIN_USER
export BROKER_USER_PASSWORD=$ADMIN_PASSWORD
export BROKER_VERSION=1
export BROKER_WORKER_VERSION=1
export ENABLE_GLOBAL_ACCESS=true
export BROKER_PLAN_NAMES=p-circuit-breaker-dashboard,p-config-server,p-service-registry
export PERSISTENCE_STORE_TYPE=mysql
export MESSAGE_BUS_TYPE=rabbitmq
export INSTANCES_SPACE_USER=$ADMIN_USER
export INSTANCES_SPACE_USER_PASSWORD=$ADMIN_PASSWORD
export PACKAGE_PATH=./spring-cloud-service-broker
export APP_PUSH_TIMEOUT=180
export APP_PUSH_MEMORY=512M
export SECURITY_USER_NAME=$ADMIN_USER
export SECURITY_USER_PASSWORD=$ADMIN_PASSWORD

export SKIP_CERT_VERIFY=true
export CF_TARGET=https://api.$SYSTEM_DOMAIN
