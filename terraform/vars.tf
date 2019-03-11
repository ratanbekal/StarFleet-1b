terraform {
  backend "s3" {
    bucket = "starfleet1-terraform-session-ap-south-1" # ! REPLACE WITH YOUR TERRAFORM BACKEND BUCKET
    key    = "starfleet1-terraform-session-ap-south-1"
    region = "ap-south-1"
  }
}
variable "S3_BACKEND_BUCKET" {
  default = "starfleet1-terraform-session-ap-south-1" # ! REPLACE WITH YOUR TERRAFORM BACKEND BUCKET
}

variable "S3_BUCKET_REGION" {
  type    = "string"
  default = "ap-south-1"
}

variable "AWS_REGION" {
  type    = "string"
  default = "ap-south-1"
}

variable "TAG_ENV" {
  default = "dev"
}

variable "ENV" {
  default = "PROD"
}

variable "CIDR_PRIVATE" {
  default = "10.0.1.0/24,10.0.2.0/24"
}

variable "CIDR_PUBLIC" {
  default = "10.0.101.0/24,10.0.102.0/24"
}
