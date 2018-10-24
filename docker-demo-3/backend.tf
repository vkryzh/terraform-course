terraform {
  backend "s3" {
    bucket = "terraform-state-devops-trainer"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
