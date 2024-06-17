terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.36.0"
    }
  }
}

provider "huaweicloud" {
  region     = "sa-brazil-1"
  access_key = "1S3J4PZX3XUDM9DJ0AIK"
  secret_key = "WsXiJgOWYiUqEkPa4Iv3uFTk8iu3qgw3TamhHgl6"
}