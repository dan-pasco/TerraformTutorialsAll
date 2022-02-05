
resource "aws_instance" "db_instance" {
  ami           = "ami-0c635ee4f691a2310"
  instance_type = "t2.micro"
  
  
  tags = {
    Name = "DB Server"
}
}