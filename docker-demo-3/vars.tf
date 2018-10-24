variable "AWS_REGION" {
  default = "us-east-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t3.micro"
}

# Full List: https://cloud-images.ubuntu.com/locator/ec2/
variable "ECS_AMIS" {
  type = "map"
  default = {
    us-east-2 = "ami-0a0c6574ce16ce87a"
  }
}
# Full List: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html

variable "AMIS" {
  type = "map"
  default = {
    us-east-2 = "ami-04c305e118636bc7d"
  }
}
variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "JENKINS_VERSION" {
  default = "2.138.2"
}

