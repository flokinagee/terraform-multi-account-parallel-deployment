  variable "cw_name" {
      description = "CloudWatch LogGroup Name"
      type = string
      default = ""
    
  }


variable "tags" {
      description = "tags"
      type = map(string)
      default = {} 
}

variable "retention_in_days" {
      description = "CloudWatch LogGroup Name prefix"
      type = number
      default = null   
}

variable "kms_key_id" {
      description = "KMS Key to encrypt CW Logroup"
      type = string
      default = ""    
}