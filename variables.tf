variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_access_Token" {
  type = string
}
# variable "bucket_name" {
#   type = string
# }

variable "arcane" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "manu" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "terratowns_endpoint" {
  type = string
}