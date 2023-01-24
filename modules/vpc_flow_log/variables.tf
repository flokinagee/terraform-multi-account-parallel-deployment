variable "vpc_id" {
    type = string
    default = ""
}

variable "vpc_name" {
    type = string
    default = ""
}

variable "logs_retention" {
    type = number
    default = null
}

########
variable "log_destination_s3" {
  description = "VPC flow log will be sent to S3"
  type        = bool
  default     = true
}

variable "vpc_flowlog_bucket_arn" {
  description = "VPC flow log will be sent to S3 Central S3 bucket in logging account"
  type        = string
  default     = ""
}

variable "cw_kms" {
    type = string
    default = ""
    description = " CW Loggroup KMS Key"
}
