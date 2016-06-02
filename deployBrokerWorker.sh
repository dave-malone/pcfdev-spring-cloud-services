#modified version of deployBrokerWorker.sh

set -e -x

source scripts/includes/logging.sh
source scripts/includes/deployment.sh

log_debug "Pushing app"
#push_broker_apps
check_version "https://${APP_URI}.${APP_DOMAIN}/info" ${BROKER_VERSION}

if is_venerable_broker_deployed; then
  delete_venerable_broker
fi

if ( cf app ${BROKER_APP_NAME} ); then
  cf rename $BROKER_APP_NAME $BROKER_APP_NAME-venerable
  cf map-route $BROKER_APP_NAME-venerable ${APP_DOMAIN} -n ${APP_URI}-venerable
fi

cf push $BROKER_APP_NAME -p $PACKAGE_PATH/spring-cloud-service-broker.jar -n ${APP_URI} -d ${APP_DOMAIN} -t ${APP_PUSH_TIMEOUT} -m $APP_PUSH_MEMORY --no-start
cf set-env ${BROKER_APP_NAME} SECURITY_USER_NAME ${BROKER_USER_NAME}
cf set-env ${BROKER_APP_NAME} SECURITY_USER_PASSWORD ${BROKER_USER_PASSWORD}
cf set-env ${BROKER_APP_NAME} BROKER_CLIENT_SECRET ${BROKER_CLIENT_SECRET}
cf set-env ${BROKER_APP_NAME} BROKER_MAX_INSTANCES ${BROKER_MAX_INSTANCES}

if ( cf app ${WORKER_APP_NAME} ); then
  cf rename $WORKER_APP_NAME $WORKER_APP_NAME-venerable
fi

cf push ${WORKER_APP_NAME} -p $PACKAGE_PATH/spring-cloud-service-broker-worker.jar -t $APP_PUSH_TIMEOUT -m $APP_PUSH_MEMORY --no-start
cf set-env ${WORKER_APP_NAME} SPRING_PROFILES_ACTIVE cloud
cf set-env ${WORKER_APP_NAME} CF_TARGET ${CF_TARGET}
cf set-env ${WORKER_APP_NAME} CF_USER ${INSTANCES_SPACE_USER}
cf set-env ${WORKER_APP_NAME} CF_PASSWORD ${INSTANCES_SPACE_USER_PASSWORD}
cf set-env ${WORKER_APP_NAME} CF_ORG ${INSTANCES_ORG}
cf set-env ${WORKER_APP_NAME} CF_SPACE ${INSTANCES_SPACE}
cf set-env ${WORKER_APP_NAME} WORKER_CLIENT_ID ${WORKER_CLIENT_ID}
cf set-env ${WORKER_APP_NAME} WORKER_CLIENT_SECRET ${WORKER_CLIENT_SECRET}
cf set-env ${WORKER_APP_NAME} SECURITY_USER_NAME ${WORKER_USER_NAME}
cf set-env ${WORKER_APP_NAME} SECURITY_USER_PASSWORD ${WORKER_USER_PASSWORD}
log_debug "Pushed app"

log_debug "Provisioning database"
provision_db

log_debug "Provisioning message bus"
provision_message_bus

source $START_DIR/setupServiceBrokerEnv.sh
log_debug "Updated app env variable"

log_debug "Starting app"
start_app
log_debug "App started!!"

log_debug "Scaling up the scs broker app"
cf scale $BROKER_APP_NAME -m 1024M -f
log_debug "Memory increased for the scs broker"
