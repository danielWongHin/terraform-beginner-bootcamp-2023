terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "ExamPro"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_Token
}

module "terrahouse_aws" {
  assets_path = var.assets_path
 source = "./modules/terrahouse_aws"
 user_uuid = var.teacherseat_user_uuid
 index_html_filepath = var.index_html_filepath
 error_html_filepath = var.error_html_filepath
 content_version = var.content_version
}


resource "terratowns_home" "home" {
  name = "Success of Manchester  United !!"
  description = <<DESCRIPTION
Manchester United Football Club, commonly referred to as Man United, or simply United, is a professional football club based in Old Trafford, Greater Manchester, England. The club competes in the Premier League, the top division in the English football league system
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}
