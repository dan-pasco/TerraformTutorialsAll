
variable "ingressvar" {

  type = list(number)
  default = [ 80,443,22 ]
  
}

variable "egressvar" {

  type = list(number)
  default = [ 80,443,22 ]
  
}



resource "aws_security_group" "ec2_sg" {

  name = "Allow Traffic"

  dynamic "ingress"{
    iterator = port
    for_each = var.ingressvar
    content{
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  dynamic "egress"{
    iterator = port
    for_each = var.egressvar
    content{
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  
  tags = {

    Name = "Allow Tls"

  }
}

output "sg_name" {

  value = aws_security_group.ec2_sg.name
  
}