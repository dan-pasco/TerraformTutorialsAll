provider "aws" {

    region = "ap-southeast-2"
  
}

module "db" {

    source = "./db"
  
}


module "web" {

    source = "./web"
  
}



output "web_public" {
    value = module.web.web_public_ip
}







