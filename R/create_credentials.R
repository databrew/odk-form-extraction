# Description:
# - This script is used for creating credentials to instantiate bohemiase
# - It creates bohemia credentials and save it into dot file stored in $HOME directory
#
# Author: Aryton Tediarjo (atediarjo@gmail.com)
library(yaml)
library(paws)
library(magrittr)
library(config)
library(aws.s3)
library(ruODK)


message("Log Message: Creating Bohemiase credentials into yaml file")

# get ODK credentials from secrets manager
svc  <- paws::secretsmanager()
creds <- svc$get_secret_value(Sys.getenv('ODK_CREDENTIALS_SECRETS_NAME')) %>%
  .$SecretString %>%
  jsonlite::parse_json(.)

# write to yaml file as . systems file
out <- list(
  url= 'https://databrew.org',
  un= 'atediarjo@gmail.com',
  pw= 'jakartabicycle'
)

# write to yaml
yaml::write_yaml(out, "~/.bohemia_credentials")
message("Log Message: credentials created")




