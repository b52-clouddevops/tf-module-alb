# Creates Security Group for Public ALB
resource "aws_security_group" "alb_public" {
  name        = "roboshop-public-${var.ENV}-alb-sg"
  description = "Allows http inbound traffic from internet only"
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
    Name = "roboshop-public-${var.ENV}-alb-sg"
  }
}

# Creates Security Group for Private ALB
resource "aws_security_group" "alb_private" {
  name        = "roboshop-private-${var.ENV}-alb-sg"
  description = "Allows traffic only from public load-balancer"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "Allow HTTP from Intranet Only"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = data.terraform_remote_state.vpc.outputs.VPC_CIDR   # [] represent's list. 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-private-${var.ENV}-alb-sg"
  }
}