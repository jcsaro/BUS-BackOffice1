
variable "webapp_name" {
  description = "web app name"
  type        = string
}

variable "name_microservices_api" {
  description = "name to publis the api in api management"
  type        = string
}

variable "create_appservice_slot" {
  description = "create slot staging in the app services"
  type        = bool
  default     = false
}

variable "always_on_appservices" {
  description = "enable always on in app services"
  type        = bool
  default     = false
}

variable "verification_otp_length" {
  description = "verification otp length"
  type        = string
  default     = null
}

variable "is_verification_otp_numeric" {
  description = "is verification otp numeric"
  type        = string
  default     = null
}

variable "azure_blob_storage_expiry_time" {
  description = "time to expiry the token to access a image using SAS token in the blob storage"
  type        = string
  default     = null
}

variable "always_on" {
  description = "config app parameter always on"
  type        = string
}

variable "service_plan_id" {
  description = "service plan to run the app service"
  type        = string
  default     = null
}

variable "enable_hight_availability" {
  description = "enable hight avalilability"
  type        = bool
  default     = false
}

variable "number_slots_versions" {
  description = "number of aditional slots to deploy others service versions"
  type        = number
  default     = 0
}
variable "enable_subnet_integration" {
  description = "enable subnet integration in app services"
  type        = bool
  default     = false
}


variable "service_plan_sku" {
  description = "service plan sku"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "vnet integration subnet id"
  type        = string
  default     = null
}

variable "subnets" {
  description = "vnet integration subnets list to allow access"
  type        = list(string)
  default     = null
}

variable "subnet_secondary_id" {
  description = "vnet integration secondary subnet id"
  type        = string
  default     = null
}

variable "subnets_secondary" {
  description = "vnet integration secondary subnets list to allow access"
  type        = list(string)
  default     = null
}

variable "public_network_access_enabled" {
  description = "value"
  type        = string
  default     = null
}

variable "container_registry_loginserver" {
  description = "container registry with the image to load, login server"
  type        = string
}

variable "image_name" {
  description = "image name in the container registry"
  type        = string
}

variable "container_registry_pwd" {
  description = "container registry with the image to load, password"
  type        = string
}

variable "key_vault_id" {
  description = "key vault (id) with the secrets information for the service "
  type        = string
}

variable "container_registry_user" {
  description = "container registry with the image to load, user"
  type        = string
}
variable "principal_resource_location" {
  description = "Principal Location for the azure resources"
  type        = string
}

variable "principal_resource_location_acronym" {
  description = "Principal Location for the azure resources acronym"
  type        = string
}

variable "secondary_resource_location" {
  description = "secondary Location for the azure resources"
  type        = string
  default     = null
}

variable "secondary_service_plan_id" {
  description = "secondary service plan id"
  type        = string
  default     = null
}


variable "secondary_resource_location_acronym" {
  description = "secondary Location for the azure resources acronym"
  type        = string
  default     = null
}

variable "environment" {
  description = "Enviroment"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name for the resource"
  type        = string
}

variable "tags_mandatory" {
  type        = map(string)
  description = "List of Mandatory tags"
}

variable "tenant_id" {
  type        = string
  description = "tenant id"
}

variable "redis_connection_string" {
  description = "redis connection string"
  type        = string
  default     = null
}
variable "cosmos_connection_string" {
  description = "redis connection string"
  type        = string
  default     = null
}

variable "configuration_service_connection_string" {
  type        = string
  description = "connection string configuration service"
  default     = null
}

variable "cosmos_account_endpoint" {
  type        = string
  description = "cosmosdb account endpoint"
  default     = null
}

variable "cosmos_account_key" {
  type        = string
  description = "cosmosdb account key"
  default     = null
}

variable "confluent_username" {
  type        = string
  description = "confluent api key username"
  default     = null
}

variable "confluent_password" {
  type        = string
  description = "confluent api key password"
  default     = null
}

variable "event_broker" {
  type        = string
  description = "confluent rest endpoint"
  default     = null
}

variable "payments_kafka_retry_backoff_ms" {
  type        = number
  description = "confluent kafka retry backoff ms"
  default     = null
}

variable "golden_profile_topic" {
  type        = string
  description = "name of the golden profile topic"
  default     = null
}

variable "identity_payment_method_topic" {
  type        = string
  description = "name of the identity payment method topic"
  default     = null
}

variable "identity_intuit_dome_account_topic" {
  type        = string
  description = "identity intuit dome account topic"
  default     = null
}

variable "identity_aifi_new_account_topic" {
  type        = string
  description = "name of the identity aifi new account topic"
  default     = null
}

variable "identity_ticketing_record_topic" {
  type        = string
  description = "name of identity ticketing record topic"
  default     = null
}

variable "identity_identity_pass_topic" {
  type        = string
  description = "name of identity pass topic"
  default     = null
}

variable "apple_client_handshake_certificate" {
  type        = string
  description = "apple client handshake certificate"
  default     = null
}
variable "apple_client_handshake_private_key" {
  type        = string
  description = "apple client handshake private key"
  default     = null
}
variable "apple_client_handshake_certificate_password" {
  type        = string
  description = "apple client handshake certificate password"
  default     = null
}
variable "apple_ts_client_handshake_certificate" {
  type        = string
  description = "apple ts client handshake certificate"
  default     = null
}
variable "apple_ts_server_handshake_certificate" {
  type        = string
  description = "apple ts server handshake certificate"
  default     = null
}
variable "apple_server_handshake_certificate_password" {
  type        = string
  description = "apple server handshake certificate password"
  default     = null
}

variable "apple_certificate" {
  type        = string
  description = "apple jwt certificate"
  default     = null
}

variable "apple_private_key" {
  type        = string
  description = "apple jwt private key"
  default     = null
}

variable "azure_blob_store_url" {
  type        = string
  description = "azure blob store url"
  default     = null
}
variable "azure_blob_store_name" {
  type        = string
  description = "azure blob store name"
  default     = null
}
variable "azure_blob_store_key" {
  type        = string
  description = "azure blob store key"
  default     = null
}


variable "account_relationships_topic" {
  type        = string
  description = "name of the account relationships topic"
  default     = null
}

variable "clear_auth_base_url" {
  type        = string
  description = "clear auth url"
  default     = null
}

variable "clear_full_api_key" {
  type        = string
  description = "clear api key"
  default     = null
}

variable "clear_full_client_id" {
  type        = string
  description = "clear client id"
  default     = null
}

variable "clear_full_client_secret" {
  type        = string
  description = "clear client secret"
  default     = null
}

variable "clear_full_redirect_uri" {
  type        = string
  description = "clear redirect uri"
  default     = null
}

variable "clear_user_info_base_url" {
  type        = string
  description = "clear user info base url"
  default     = null
}

variable "nba_base_url" {
  type        = string
  description = "nba base url"
  default     = null
}

variable "nba_api_key" {
  type        = string
  description = "nba base url"
  default     = null
}

variable "entitlement_events_topic" {
  type        = string
  description = "name entitlement topic"
  default     = null
}

variable "ticketing_data_topic" {
  description = "topic for data team information"
  type        = string
  default     = null
}

variable "postgresql_url" {
  description = "postgresql url"
  type        = string
  default     = null
}

variable "postgresql_user_name" {
  description = "postgresql username"
  type        = string
  default     = null
}

variable "postgresql_password" {
  description = "postgresql password"
  type        = string
  default     = null
}
variable "api_management_name" {
  description = "api management to publish apis"
  type        = string
  default     = null
}

variable "full_api_product" {
  description = "product contains all apis"
  type        = string
  default     = null
}

variable "api_management_resource_group_name" {
  description = "api management to publish apis"
  type        = string
  default     = null
}

variable "api_definition_path" {
  description = "path with the openapi definition"
  type        = string
  default     = null
}

variable "ticketing_cron_fetch_events" {
  description = "ticketing cron fetch events"
  type        = string
  default     = null
}

variable "azure_config_host" {
  description = "azure service configuration host"
  type        = string
  default     = null
}

variable "ticketing_datasource_schema" {
  description = "ticketing datasource schema"
  type        = string
  default     = null
}

variable "access_control_event_topic" {
  description = "access control even topic name"
  type        = string
  default     = null
}

variable "ticketing_cron_ticket_availability" {
  description = "ticketing cron ticket availability"
  type        = string
  default     = null
}

variable "ticketing_cron_account_seats" {
  description = "ticketing cron account seats"
  type        = string
  default     = null
}

variable "ticketing_cron_release_seats" {
  description = "ticketing cron release seats"
  type        = string
  default     = null
}

variable "ticketing_cron_expired_transactions" {
  description = "ticketing cron expired transactions"
  type        = string
  default     = null
}

variable "ticketing_cron_active_events" {
  description = "ticketing cron active events"
  type        = string
  default     = null
}

variable "ticketing_cron_fecth_accounts" {
  description = "ticketing cron fecth accounts"
  type        = string
  default     = null
}

variable "ticketing_cron_fecth_service_charges" {
  description = "ticketing cron service charges"
  type        = string
  default     = null
}


variable "payments_add_paymentmethod_topic" {
  type        = string
  description = "name for add payment method topic"
  default     = null
}

variable "payments_delete_paymentmethod_topic" {
  type        = string
  description = "name for delete payment method topic"
  default     = null
}

variable "payments_update_paymentmethod_topic" {
  type        = string
  description = "name for update payment method topic"
  default     = null
}

variable "payments_add_method_topic" {
  type        = string
  description = "payment add method topic"
  default     = null
}

variable "loyalty_first_paymentmethod_topic" {
  type        = string
  description = "loyalty first paymentmethod topic name"
  default     = null
}

variable "loyalty_events_playfab_topic" {
  type        = string
  description = "loyalty events playfab topic name"
  default     = null
}

variable "cosmos_query_metrics" {
  type        = string
  description = "cosmos query metrics"
  default     = null
}

variable "cosmos_telemetry" {
  type        = string
  description = "cosmos telemetry"
  default     = null
}

variable "loyalty_seat_pairing_topic" {
  type        = string
  description = "loyalty seat pairing topic name"
  default     = null
}

variable "ticketing_ticket_master_host" {
  description = "ticketmaster host"
  type        = string
  default     = null
}

variable "ticketing_ticket_master_api_key" {
  description = "ticketmaster api key"
  type        = string
  default     = null
}

variable "ticketing_ticket_master_dsn" {
  description = "ticketmaster dsn"
  type        = string
  default     = null
}

variable "ticketing_ticket_master_max_attempts" {
  description = "ticketmaster max attempts"
  type        = string
  default     = null
}

variable "ticketing_ticket_master_init_backoff" {
  description = "ticketmaster init backoff"
  type        = string
  default     = null
}


variable "appinsights_connection_string" {
  description = "application insights connection string"
  type        = string
}

variable "appinsights_intrumentation_key" {
  description = "application insight intrumentation key"
  type        = string
  default     = ""
}

variable "appinsights_tracing_sampling" {
  description = "application insight tracing_sampling"
  type        = number
  default     = null
}

variable "redis_max_cache_size" {
  description = "max cache size"
  type        = string
  default     = null
}

variable "redis_expire_cache_after_write" {
  description = "expire cache after write"
  type        = string
  default     = null
}

variable "identity_service_base_uri" {
  description = "identity microservice url"
  type        = string
  default     = null
}

variable "identity_service_base_secondary_uri" {
  description = "identity microservice secondary url"
  type        = string
  default     = null
}

variable "ticketing_service_base_uri" {
  description = "ticketing microservice url"
  type        = string
  default     = null
}


variable "ticketing_service_base_secondary_uri" {
  description = "ticketing microservice secondary url"
  type        = string
  default     = null
}

variable "frictionless_service_base_uri" {
  description = "frictionless microservice url"
  type        = string
  default     = null
}

variable "frictionless_service_base_secondary_uri" {
  description = "frictionless microservice secondary url"
  type        = string
  default     = null
}


variable "payments_service_base_uri" {
  description = "payments microservice url"
  type        = string
  default     = null
}

variable "payments_service_base_secondary_uri" {
  description = "payments microservice secondary url"
  type        = string
  default     = null
}


variable "paravision_base_uri" {
  description = "paravision base url"
  type        = string
  default     = null
}

variable "paravision_known_catalog" {
  description = "paravision known catalog"
  type        = string
  default     = null
}

variable "paravision_unknown_catalog" {
  description = "paravision unknown catalog"
  type        = string
  default     = null
}

variable "paravision_unknown_shopper_catalog" {
  description = "paravision unknown shopper catalog"
  type        = string
  default     = null
}

variable "queue_management_events_topic" {
  type        = string
  description = "name for the issues topic"
  default     = null
}

variable "notifications_topic" {
  type        = string
  description = "name for the notifications topic"
  default     = null
}

variable "queue_management_events_dl_topic" {
  type        = string
  description = "name for the events dl topic"
  default     = null
}

variable "queue_management_resolution_topic" {
  type        = string
  description = "name for the resolution topic"
  default     = null
}



variable "aifi_access_token" {
  type        = string
  description = "name for the issues topic"
  default     = null
}

variable "aifi_base_url" {
  type        = string
  description = "AIFI base url"
  default     = null
}

variable "access_control_base_url" {
  type        = string
  description = "access control base url"
  default     = null
}

variable "genetec_login_credentials" {
  type        = string
  description = "genetec login credentials"
  default     = null
}
variable "genetec_base_url" {
  type        = string
  description = "genetec base url"
  default     = null
}

variable "cms_adobe_login_base_uri" {
  description = "cms adobe login base uri "
  type        = string
  default     = null
}

variable "cms_adobe_platform_host" {
  description = "cms adobe platform host"
  type        = string
  default     = null
}
variable "cms_adobe_sandbox_env" {
  description = "cms adobe sandbox enviroment"
  type        = string
  default     = null
}
variable "cms_adobe_api_key" {
  description = "cms adobe api key"
  type        = string
  default     = null
}
variable "cms_adobe_grant_type" {
  description = "cms adobe grant type"
  type        = string
  default     = null
}
variable "cms_adobe_client_id" {
  description = "cms adobe client id"
  type        = string
  default     = null
}
variable "cms_adobe_client_secret" {
  description = "cms adobe client secret"
  type        = string
  default     = null
}

variable "cms_adobe_scopes" {
  description = "cms adobe scopes value1,value2,value3,..."
  type        = string
  default     = null
}

variable "cms_adobe_campaign_id" {
  description = "cms adobe campaign id"
  type        = string
  default     = null
}

variable "cms_adobe_request_id" {
  description = "cms adobe request id"
  type        = string
  default     = null
}

variable "phone_message" {
  description = "phone message"
  type        = string
  default     = null
}
variable "infobip_base_uri" {
  description = "infobip base uri"
  type        = string
  default     = null
}
variable "voip_value" {
  description = "voip value."
  type        = string
  default     = null
}
variable "infobip_api_key" {
  description = "infobip api key"
  type        = string
  default     = null
}


variable "cms_host" {
  description = "cms host url"
  type        = string
  default     = null
}

variable "shops_buffer_size" {
  description = "shops buffer size"
  type        = number
  default     = null
}

variable "nba_play_by_play_event_topic" {
  description = "play by play event topic name"
  type        = string
  default     = null
}


variable "nba_game_scores_event_topic" {
  description = "game score topic name"
  type        = string
  default     = null
}

variable "resolution_queue" {
  description = "resolution queue"
  type        = string
  default     = null
}



variable "spring_activeProfiles" {
  description = "springboot activeProfiles"
  type        = string
  default     = null
}

variable "queue_management_base_url" {
  type        = string
  description = "queue management base url"
  default     = null
}

variable "payments_first_paymentmethod_topic" {
  type        = string
  description = "name for update payment method topic"
  default     = null
}

variable "payments_methods_mgmt_topic" {
  type        = string
  description = "name for payment method mgmt topic"
  default     = null
}

variable "payments_notification_history_topic" {
  type        = string
  description = "name for payment notification topic"
  default     = null
}

variable "authenticator_access_id" {
  description = "authenticator access id"
  type        = string
  default     = null
}

variable "authenticator_grant_type" {
  description = "authenticator grant type"
  type        = string
  default     = null
}

variable "authenticator_client_secret" {
  description = "authenticator client secret"
  type        = string
  default     = null
}

variable "authenticator_client_id" {
  description = "authenticator client id"
  type        = string
  default     = null
}

variable "authenticator_resource" {
  description = "authenticator resource"
  type        = string
  default     = null
}

variable "microsoft365_base_url" {
  description = "microsoft365 base url"
  type        = string
  default     = null
}
variable "microsoft365_getorderhistory_top" {
  description = "microsoft365 getorderhistory top"
  type        = string
  default     = null
}
variable "microsoft365_api_version" {
  description = "microsoft365 api version"
  type        = string
  default     = null
}
variable "microsoft365_header_oun" {
  description = "microsoft365 header uon"
  type        = string
  default     = null
}

variable "apple_aud" {
  description = "apple uad"
  type        = string
  default     = null
}

variable "apple_iss" {
  description = "apple iss"
  type        = string
  default     = null
}

variable "apple_kid" {
  description = "apple kid"
  type        = string
  default     = null
}

variable "apple_sub" {
  description = "apple sub"
  type        = string
  default     = null
}

variable "apple_private_key_jwt" {
  description = "apple private ket jwt"
  type        = string
  default     = null
}

variable "apple_jwks" {
  description = "apple jwks"
  type        = string
  default     = null
}


variable "frontdoor_microservices_id" {
  description = "frontdoor microservices id"
  type        = string
  default     = null
}

variable "frontdoor_endpoint_id" {
  description = "cdn endpoint id"
  type        = string
  default     = null
}

variable "frontdoor_endpoint_url" {
  description = "cdn endpoint url"
  type        = string
  default     = null
}

variable "cdn_front_door_guid" {
  description = "cdn front door guid"
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

variable "ticketing_android_client_id" {
  description = "ticketing android client id"
  type        = string
  default     = null
}

variable "ticketing_android_secret_key" {
  description = "ticketing android secret key"
  type        = string
  default     = null
}

variable "ticketing_ios_client_id" {
  description = "ticketing ios client id"
  type        = string
  default     = null
}

variable "ticketing_ios_secret_key" {
  description = "ticketing ios secret key"
  type        = string
  default     = null
}

variable "ticketing_expiration_time_in_minutes" {
  description = "ticketing expiration time in minutes"
  type        = number
  default     = null
}

variable "tracing_sampling" {
  description = "tracing sampling"
  type        = string
  default     = null
}

variable "lac_website_add_for_ext_integration" {
  description = "lac website add for ext integration"
  type        = string
  default     = null
}
variable "lac_app_name_for_ext_integration" {
  description = "lac app name for ext integration"
  type        = string
  default     = null
}
variable "google_wallet_scope" {
  description = "google wallet scope"
  type        = string
  default     = null
}
variable "google_wallet_save_uri" {
  description = "google wallet save uri"
  type        = string
  default     = null
}
variable "google_wallet_logo_uri" {
  description = "google wallet logo uri"
  type        = string
  default     = null
}
variable "google_wallet_issuer_id" {
  description = "google wallet issuer id"
  type        = string
  default     = null
}
variable "google_wallet_identity_pass_class_suffix" {
  description = "google wallet identity pass class suffix"
  type        = string
  default     = null
}
variable "google_wallet_identity_pass_card_title" {
  description = "google wallet identity pass card title"
  type        = string
  default     = null
}
variable "google_wallet_identity_pass_card_image_uri" {
  description = "google wallet identity pass card image uri"
  type        = string
  default     = null
}
variable "google_wallet_identity_pass_card_color" {
  description = "google wallet identity pass card color"
  type        = string
  default     = null
}

variable "google_wallet_api_key" {
  description = "google wallet api key"
  type        = string
  default     = null
}