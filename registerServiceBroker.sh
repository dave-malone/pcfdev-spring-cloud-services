#registerServiceBroker.sh

set -e

ENABLE_GLOBAL_ACCESS=${ENABLE_GLOBAL_ACCESS:-true}

if [ "$1" != "" ]; then
  source $1
fi

source scripts/includes/logging.sh
source scripts/includes/cf.sh
source scripts/includes/brokerRegistration.sh

cf_authenticate_and_target
log_debug "Authenticated and targeted CF"

register_broker
log_debug "Broker registered"

if [ "${ENABLE_GLOBAL_ACCESS}" == "true" ]; then
  enable_global_access
  log_debug "Plans publicized"
fi
