# Creates Security Group
resource "aws_security_group" "alb_public" {
  name        = "roboshop-public-${var.ENV}-alb-sg"
  description = "Allows inbound traffic from intranet only"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # [] represent's list. 
  }

#   ingress {
#     description = "Allow RDS From Default VPC Network"
#     from_port   = var.RDS_MYSQL_PORT 
#     to_port     = var.RDS_MYSQL_PORT
#     protocol    = "tcp"
#     cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]   # [] represent's list. 
#   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-mysql-sg"
  }
}