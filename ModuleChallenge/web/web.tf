




resource "aws_instance" "web_instance" {
  ami           = "ami-0c635ee4f691a2310"
  instance_type = "t2.micro"
  security_groups = [ module.sg.sg_name]
  user_data = ("./web/script.sh")
  
  tags = {
    Name = "Web Server"
}
}

module "eip"{

    source = "../eip"
    instance_id = aws_instance.web_instance.id
}

module "sg" {

    source = "../sg"

  
}

output "web_public_ip" {

    value = aws_instance.web_instance.public_ip
  
}

output "web_instance_id" {

    value = aws_instance.web_instance.id
  
}