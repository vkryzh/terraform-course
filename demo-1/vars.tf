variable "HOME_PATH" {}
variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = "map"
  default = {
    us-east-2 = "ami-0e7589a8422e3270f"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-0d729a60"
  }
}
