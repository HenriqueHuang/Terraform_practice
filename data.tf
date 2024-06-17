data huaweicloud_availability_zones zones {
    region = "sa-brazil-1"
}

data "huaweicloud_compute_flavors" "data_ecs_flavor" {
  availability_zone = data.huaweicloud_availability_zones.zones.names[1]
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 8
}

data "huaweicloud_images_image" "image_ubuntu" {
  name = "Ubuntu 22.04 server 64bit"
  most_recent = true
}

data "huaweicloud_rds_flavors" "data_rds_flavor" {
  db_type       = "MySQL"
  db_version    = "5.7"
  instance_mode = "ha"
}

data "huaweicloud_rds_instances" "data_rds_instance" {
  name = "rds-instance"
}

data "huaweicloud_gaussdb_mysql_flavors" "data_gaussdb_flavors" {
}