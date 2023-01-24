provider "aws" {
    region = "ap-southeast-1"
    alias = "prod"
    assume_role {
        role_arn = "arn:aws:iam::0123456789101:role/atest1"
    }
}

provider "aws" {
    region = "ap-southeast-1"
    alias = "nonprod"
    assume_role {
        role_arn = "arn:aws:iam::0123456789101:role/test1"
    }
}