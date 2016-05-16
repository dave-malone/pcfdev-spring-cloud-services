#modified version of deployBrokerWorker.sh

set -e -x

source scripts/includes/logging.sh
source scripts/includes/deployment.sh

log_debug "Pushing app"
push_broker_apps
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
