provider "aws" {

    region = "ap-southeast-2"
  
}
#   DECLARE DB MODULE
module "db" {

    source = "./db"
  
}

# DECLARE WEB MODULE
module "web" {

    source = "./web"
  
}



# USED OUTPUT OF WEB MODULE TO GET EIP STATIC 
output "web_public" {
    value = module.web.web_public_ip
}









