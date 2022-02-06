




resource "aws_instance" "web_instance" {
  ami           = "ami-0c635ee4f691a2310"
  instance_type = "t2.micro"
  # OUTPUT OF SG NAME USED
  security_groups = [ module.sg.sg_name]
  key_name =  "EC2website"
  user_data =  file ("./web/script.sh")
  
  tags = {
    Name = "Web Server"
}
}

# EIP IS DECALRED TO BE USED
module "eip"{

    source = "../eip"
    # REQUIRED INSTANCE ID USED
    instance_id = aws_instance.web_instance.id
}
# SG IS DECLARED TO BE USED
module "sg" {

    source = "../sg"

  
}
# GET OUTPUT FROM EIP
output "web_public_ip" {

    value = module.eip.static_ip
  
}


