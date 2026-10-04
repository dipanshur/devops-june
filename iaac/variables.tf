variable "batch_code" {
    description = "provide batch code for which you are creating this vpc"
    default = "test-batch"
    type = string
  
}

variable "vpc_cidr" {
    description = "provide a cidr block for the vpc"
    type = string
  
}

variable "environment" {
    description = "Type of environment like dev, preprod, prod"
    type = string
  
}

variable "public_subnet_az" {
    description = "provide az for public subnet"
    type = string
  
}

variable "private_subnet_az" {
    description = "provide az for private subnet"
  
}

variable "public_subnet_cidr" {
    description = "provide cidr for public subnet"
  
}

variable "private_subnet_cidr" {
    description = "provide cidr for private subnet"
  
}

variable "extra_private_subnet_needed" {
    description = "provide true if you want to create extra private subnet"
    type = bool
    default = false
  
}

variable "extra_private_subnet_pool" {
    description = "provide cidr for extra private subnet"
    type = list(string)
    default = ["10.0.16.0/24", "10.0.17.0/24", "10.0.18.0/24"]
  
}

variable "ingress_rules" {
    description = "provide ingress rules for security group"
    type = map(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
  
}

variable "egress_rules" {
    description = "provide egress rules for security group"
    type = map(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
  
}