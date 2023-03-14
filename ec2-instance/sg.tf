resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
=============
# --------------------------------------------------------------------------
# SecurityGroup - bastion
# --------------------------------------------------------------------------
resource "aws_security_group" "bastion" {
  name_prefix = "bastion-"
  description = "Bastion Host"
  vpc_id      = aws_vpc.vpc.id

  tags = local.tags
}


resource "aws_security_group_rule" "egress-bastion" {
  description       = "bastion - ALL egress"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  to_port           = 65535
  type              = "egress"
}


resource "aws_security_group_rule" "workstation-ssh-bastion" {
  description       = "bastion - SSH workstation"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  to_port           = 22
  type              = "ingress"
}


===================a