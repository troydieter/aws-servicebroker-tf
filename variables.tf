variable "aws_account" {
  description = "AWS Account Name"
  type        = string
}
variable "environment" {
  description = "AWS Environment"
  type        = string
}

variable "tags" {
  description = "Key/value tags to assign to all resources."
  default     = {}
  type        = map(string)
}

variable "aws-profile" {
  description = "Local AWS Profile Name "
  type        = string
}
variable "aws_region" {
  description = "aws region"
  default     = "us-east-1"
  type        = string
}