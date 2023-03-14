aws_instance_ebs_resource/variables.tf
@kmsulekha
kmsulekha Add files via upload
Latest commit 3c55590 on Sep 27, 2021
 History
 1 contributor
27 lines (21 sloc)  386 Bytes

variable "ami_id" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "availability_zone" {
  type        = string
}

variable "vpc_security_group_ids" {
  type        = list
}

variable "key_name" {
  type        = string
}

variable "disk_size" {
  type        = number
}

variable "disk_name" {
  type        = string
}
