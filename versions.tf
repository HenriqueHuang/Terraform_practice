terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.36.0"
    }
  }
}

#Put your AK and SK to connect your account
provider "huaweicloud" {
  region     = "sa-brazil-1"
  access_key = "" 
  secret_key = ""
}