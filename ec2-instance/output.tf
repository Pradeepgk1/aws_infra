resource "aws_instance" "terraform_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.availability_zone
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name = var.key_name
  tags = {
    Name = "Terraform"
         }
}

resource "aws_ebs_volume" "terraform_ebs" {
  availability_zone = var.availability_zone
  size              = var.disk_size
  tags = {
    Name = "Terraform"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.disk_name
  volume_id   = aws_ebs_volume.terraform_ebs.id
  instance_id = aws_instance.terraform_instance.id
  force_detach = true
}

