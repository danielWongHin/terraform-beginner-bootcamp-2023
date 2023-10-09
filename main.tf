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
  cloud {
   organization = "daniel-terraform"
   workspaces {
     name = "terra-house-1"
   }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_Token
}

module "home_arcane_hosting" {
 source = "./modules/terrahome_aws"
 user_uuid = var.teacherseat_user_uuid
 public_path = var.arcane.public_path
 content_version = var.arcane.content_version
}


resource "terratowns_home" "home_arcane" {
  name = "Arcane (TV series)"
  description = <<DESCRIPTION
Arcane (titled onscreen as Arcane: League of Legends) is an animated steampunk action-adventure television series created by Christian Linke and Alex Yee. It was produced by the French animation studio Fortiche under the supervision of Riot Games, and distributed by Netflix. 
DESCRIPTION
  domain_name = module.home_arcane_hosting.domain_name
  town = "missingo"
  content_version = var.arcane.content_version
}

module "home_manu_hosting" {
 source = "./modules/terrahome_aws"
 user_uuid = var.teacherseat_user_uuid
 public_path = var.manu.public_path
 content_version = var.manu.content_version
}


resource "terratowns_home" "home_manu" {
  name = "Manchester is Red"
  description = <<DESCRIPTION
Manchester United Football Club, commonly referred to as Man United, or simply United, is a professional football club based in Old Trafford, Greater Manchester, England. The club competes in the Premier League, the top division in the English football league system. 
DESCRIPTION
  domain_name = module.home_manu_hosting.domain_name
  town = "missingo"
  content_version = var.manu.content_version
}
