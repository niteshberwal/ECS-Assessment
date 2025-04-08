variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"  # Change this as needed
}

variable "repo_name" {
  description = "ECR Repository Name"
  type        = string
}

variable "fe_repo_tag" {
  description = "ECR Repository Frontend Image Tag"
  type        = string
}

variable "be_repo_tag" {
  description = "ECR Repository Backend Image Tag"
  type        = string
}

