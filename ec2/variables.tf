################################################################################
# General Variables
################################################################################

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region where our infrastructure is deployed"
}

variable "profile" {
  type        = string
  default     = "self"
  description = "AWS Profile"
}

################################################################################
# EC2 Variables
################################################################################

variable "ec2_ami" {
  type    = string
  default = "ami-08d4ac5b634553e16"
}
variable "ec2_key_pair_public_key" {
  type        = string
  default     = null
  description = "Public Used for AWS KeyPair"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_name" {
  type    = string
  default = "ec2_instance"
}

variable "public_ip_association" {
  type    = bool
  default = true
}

variable "monitoring" {
  type    = bool
  default = true
}

variable "instance_profile" {
  type    = string
  default = null
}

variable "subnet_id" {
  type    = string
  default = "subnet-001669339a8e71e6e"
}

variable "tfl_script" {
  default = "./data/install.tfl"
  type    = string
}

################################################################################
# EBS Variables
################################################################################
variable "ebs_optimized" {
  type    = bool
  default = false
}
variable "delete_on_termination" {
  type    = bool
  default = false
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "volume_type" {
  type    = string
  default = "gp2"
}
