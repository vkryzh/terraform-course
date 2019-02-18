provider "aws" {
  region                  = "${var.AWS_REGION}"
  shared_credentials_file = "${var.HOME_PATH}/.aws/credentials"
  profile                 = "default"
}
