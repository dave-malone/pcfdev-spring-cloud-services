#modified version of configureTileEnvironments.sh

set -e

source scripts/includes/logging.sh
#source scripts/includes/sslCertificates.sh
source scripts/includes/cf.sh
source scripts/includes/uaa.sh

cf_authenticate_and_target
log_debug "Authenticated and targeted CF"

cf_create_instances_org_space
cf_create_broker_org_space
log_debug "Created orgs and spaces"

cf_target_broker_org_space

cf_create_open_security_group
log_debug "Created open security group"

cf_create_instances_quota
log_debug "Created custom quota for instances org"

cf_create_instance_space_user
log_debug "Created instance space user"

uaa_create_broker_client
log_debug "Created broker client"

uaa_create_worker_client
log_debug "Created worker client"

uaa_create_identity_zone_and_admin
log_debug "created identity zone and admin"
