#VPC

resource "huaweicloud_vpc" "my_vpc" {
  name = "my_vpc"
  cidr = "172.16.0.0/16"
}
#Subnets
resource "huaweicloud_vpc_subnet" "subnet-ecs-1" {
  vpc_id = huaweicloud_vpc.my_vpc.id
  name = "subnet-ecs-1"
  cidr = "172.16.0.0/24"
  availability_zone = data.huaweicloud_availability_zones.zones.names[1] #sa-brazil-1b
  gateway_ip = "172.16.0.1"
}

resource "huaweicloud_vpc_subnet" "subnet-db-1" {
  vpc_id = huaweicloud_vpc.my_vpc.id
  name = "subnet-db-1"
  cidr = "172.16.1.0/24"
  availability_zone = local.azs[1] #sa-brazil-1b
  gateway_ip = "172.16.1.1"
}

#Security group
resource "huaweicloud_networking_secgroup" "secgroup-1" {
  name = "secgroup-1"
  description = "Secgroup for TF test"
}

resource "huaweicloud_networking_secgroup_rule" "linux-acess-port" {
  security_group_id = local.secgroup-1_id
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  ports = "22"
  remote_ip_prefix = "0.0.0.0/0"
  priority = "1"
}

resource "huaweicloud_networking_secgroup_rule" "mysql_acess_port" {
  security_group_id = local.secgroup-1_id
  direction = var.ingress #"ingress"
  ethertype = var.IPv4 #"IPv4"
  protocol = var.tcp #"tcp"
  ports = "3306"
  remote_ip_prefix = var.remote_ip_prefix #"0.0.0.0/0"
  priority = "1"
}

resource "huaweicloud_networking_secgroup_rule" "http_acess_port" {
  security_group_id = local.secgroup-1_id
  direction = var.ingress #"ingress"
  ethertype = var.IPv4 #"IPv4"
  protocol = var.tcp #"tcp"
  ports = "80"
  remote_ip_prefix = var.remote_ip_prefix #"0.0.0.0/0"
  priority = "1"
}

resource "huaweicloud_networking_secgroup_rule" "https_acess_port" {
  security_group_id = local.secgroup-1_id
  direction = var.ingress #"ingress"
  ethertype = var.IPv4  #"IPv4"
  protocol = var.tcp #"tcp"
  ports = "443"
  remote_ip_prefix = var.remote_ip_prefix #"0.0.0.0/0"
  priority = "1"
}

resource "huaweicloud_networking_secgroup_rule" "icmp_acess_port" {
  security_group_id = local.secgroup-1_id
  direction = var.ingress #"ingress"
  ethertype = var.IPv4  #"IPv4"
  protocol = var.tcp #"tcp"
  remote_ip_prefix = var.remote_ip_prefix #"0.0.0.0/0"
  priority = "1"
}

# ECS
resource "huaweicloud_vpc_eip" "eip-1" {
  publicip {
    type = "5_bgp"
  }

  bandwidth {
    share_type = "PER"
    name = "bandwith-eip-1"
    size = 100
    charge_mode = "traffic"
  }
}

resource "huaweicloud_compute_instance" "ecs-1" {
  name               = "ecs-1"
  image_id           = data.huaweicloud_images_image.image_ubuntu.id
  flavor_id          = data.huaweicloud_compute_flavors.data_ecs_flavor.ids[0]
  security_group_ids = [local.secgroup-1_id]
  availability_zone  = local.azs[1] #sa-brazil-1b
  admin_pass = var.my_pass
  
  network {
    uuid = local.subnet-ecs-1_id
  }
}

resource "huaweicloud_compute_eip_associate" "ecs1-eip1-associate" {
  public_ip   = huaweicloud_vpc_eip.eip-1.address
  instance_id = huaweicloud_compute_instance.ecs-1.id
}

#RDS for MySQL
resource "huaweicloud_rds_instance" "rds-1_instance" {
  name              = "rds-1_instance"
  flavor            = "rds.mysql.x1.large.4.ha"
  ha_replication_mode = "async"
  vpc_id            = local.my_vpc_id
  subnet_id         = local.subnet-db-1_id
  security_group_id = local.secgroup-1_id
  availability_zone = [local.azs[0],local.azs[1]] #sa-brazil-1a,sa-brazil-1b
  db {
    type     = "MySQL"
    version  = "5.7"
    password = var.my_pass
  }
  volume {
    type = "CLOUDSSD"
    size = 40
  }
}

resource "huaweicloud_gaussdb_mysql_instance" "gaussdb_instance_1" {
  name              = "gaussdb_instance_1"
  password          = var.my_pass
  flavor            = "gaussdb.mysql.2xlarge.x86.4"
  vpc_id            = local.my_vpc_id
  subnet_id         = local.subnet-db-1_id
  security_group_id = local.secgroup-1_id
}


