# This defaults to marking all variables as sensitive solely for the
# reason that highest security, rather than lowest, should be the default condition.
#
# That is, a user should have to choose which *are not* sensitive,
# rather than which *are*.

variable "project" {
  default   = "qam-project-331620"
  sensitive = true
}

variable "region" {
  default   = "us-east4"
  sensitive = true
}

variable "bucket_location" {
  # This specifies multi-region but could be single eg. "US-EAST4".
  # Once created it cannot be changed.
  default   = "US"
  sensitive = true
}
/*
# The service account credentials for terraform
variable "credentials" {
  sensitive = true
}
*/
variable "disable_apis_on_destroy" {
  default   = false
  sensitive = true
}

##
## Service names
##
## These are parameterized just in case there are existing services within a project
## that can potentially have conflicting names.
##

variable "api_service_name" {
  default   = "algomart-api"
  sensitive = true
}

variable "cms_service_name" {
  default   = "algomart-cms"
  sensitive = true
}

variable "database_server_name" {
  default   = "algomart3"
  sensitive = true
}

variable "private_ip_name" {
  default   = "algomart-private-ip"
  sensitive = true
}

variable "vpc_name" {
  default   = "algomart-vpc"
  sensitive = true
}

variable "vpc_access_connector_name" {
  # Limited to <= 24 characters
  default   = "algomart-access-conn"
  sensitive = true
}

variable "web_service_name" {
  default   = "algomart-web"
  sensitive = true
}

##
## Database
##
variable "database_server_tier" {
  default   = "db-f1-micro"
  sensitive = true
}

variable "database_max_connections" {
  # Cloud SQL defaults to 25 for db-f1-micro but this causes frequent issues like
  # "remaining connection slots reserved for superuser" errors.
  #
  # There are consistently 4 cloudsqladmin connections (6 are reserved),
  # and the CMS can have 4+ connections and the API 14+ at a time, which
  # leaves very little room for the fluctuating connections with background
  # API tasks.
  default   = 50
  sensitive = true
}

##
## API service
##

variable "api_node_env" {
  default   = "production"
  sensitive = true
}

variable "api_revision_name" {
  default   = "algomart-api"
  sensitive = true
}

##
## CMS service
##

# Directus will use these to create an "admin" user automatically

variable "cms_database_name" {
  default   = "algorand_marketplace_cms"
  sensitive = true
}
variable "cms_node_env" {
  default   = "production"
  sensitive = true
}

variable "cms_revision_name" {
  default   = "algomart-cms"
  sensitive = true
}

##
## Web service
##
/*
variable "web_domain_mapping" {
  sensitive = true
}
*/

variable "web_next_public_3js_debug" {
  default   = ""
  sensitive = true
}

variable "web_node_env" {
  default   = "production"
  sensitive = true
}

variable "web_revision_name" {
  default = "algomart-web"
  sensitive = true
}

# Values from secret manager

data "google_secret_manager_secret_version" "algod_host" {
  secret = "algod_host"
}

data "google_secret_manager_secret_version" "algod_key" {
  secret = "algod_key"
}

data "google_secret_manager_secret_version" "algod_port" {
  secret = "algod_port"
}

data "google_secret_manager_secret_version" "api_creator_passphrase" {
  secret = "api_creator_passphrase"
}

data "google_secret_manager_secret_version" "api_database_name" {
  secret = "api_database_name"
}

data "google_secret_manager_secret_version" "api_database_schema" {
  secret = "api_database_schema"
}

data "google_secret_manager_secret_version" "api_database_user_name" {
  secret = "api_database_user_name"
}

data "google_secret_manager_secret_version" "api_database_user_password" {
  secret = "api_database_user_password"
}

data "google_secret_manager_secret_version" "api_funding_mnemonic" {
  secret = "api_funding_mnemonic"
}

data "google_secret_manager_secret_version" "api_key" {
  secret = "api_key"
}

data "google_secret_manager_secret_version" "api_secret" {
  secret = "api_secret"
}

data "google_secret_manager_secret_version" "circle_key" {
  secret = "circle_key"
}

data "google_secret_manager_secret_version" "circle_url" {
  secret = "circle_url"
}

data "google_secret_manager_secret_version" "cms_admin_email" {
  secret = "cms_admin_email"
}

data "google_secret_manager_secret_version" "cms_admin_password" {
  secret = "cms_admin_password"
}

data "google_secret_manager_secret_version" "cms_database_user_name" {
  secret = "cms_database_user_name"
}

data "google_secret_manager_secret_version" "cms_database_user_password" {
  secret = "cms_database_user_password"
}

data "google_secret_manager_secret_version" "cms_key" {
  secret = "cms_key"
}

data "google_secret_manager_secret_version" "cms_secret" {
  secret = "cms_secret"
}

data "google_secret_manager_secret_version" "cms_storage_bucket" {
  secret = "cms_storage_bucket"
}

data "google_secret_manager_secret_version" "project" {
  secret = "project"
}

data "google_secret_manager_secret_version" "sendgrid_key" {
  secret = "sendgrid_key"
}

data "google_secret_manager_secret_version" "sendgrid_from_email" {
  secret = "sendgrid_from_email"
}

data "google_secret_manager_secret_version" "api_image" {
  secret = "api_image"
}

data "google_secret_manager_secret_version" "cms_image" {
  secret = "cms_image"
}

data "google_secret_manager_secret_version" "web_image" {
  secret = "web_image"
}

data "google_secret_manager_secret_version" "web_next_public_firebase_config" {
  secret = "web_next_public_firebase_config"
}

data "google_secret_manager_secret_version" "web-firebase-service-account" {
  secret = "web-firebase-service-account"
}