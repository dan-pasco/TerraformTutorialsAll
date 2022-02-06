
# AN INPUT OF INSTANCE ID NEEDED TO USE THIS MODULE
variable "instance_id" {

    type = string
  
}


resource "aws_eip" "static_add" {
  instance = var.instance_id
}

# OUTPUT THE STATIC IP TO BE USED IN WEB BECAUSE WEB DECLARED THE INSTANCE_ID VARIABLE
output "static_ip" {

  value = aws_eip.static_add.public_ip
  
}