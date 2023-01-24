variable "packer_back_ami_function" {
    description = "Lambda function name that bake AMI "
    type = string
    default = "packer_ami_creation"
}

variable "environment" {
    description = "Deployment environment (prod or nonprod) "
    type = string
    default = "nonprod"
}