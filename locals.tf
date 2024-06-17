locals {
  my_vpc_id = huaweicloud_vpc.my_vpc.id
  subnet-ecs-1_id = huaweicloud_vpc_subnet.subnet-ecs-1.id
  subnet-db-1_id = huaweicloud_vpc_subnet.subnet-db-1.id
  secgroup-1_id = huaweicloud_networking_secgroup.secgroup-1.id
  azs = data.huaweicloud_availability_zones.zones.names
}