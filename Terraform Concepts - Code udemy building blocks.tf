data "aws_availability_zones" "available" {}

resource "aws_instance" "firstdemo" {

ami = "${lookup(var.ami_type,var.region)}"

availability_zone = "${data.aws_availability_zones.available.names[0]}"

security_groups = "${var.sgs}"

instance_type="${lookup(var.instance_type,var.env)}"

 tags {

   Name = "demoinstance"

 }

}

data "aws_availability_zones" "available" {}

resource "aws_rds_cluster" "default" {

cluster_identifier      = "${var.CLUSTER_IDENTIFIER}"

engine                  = "aurora-mysql"

engine_version          = "5.8.19"

availability_zones      = ["${data.aws_availability_zones.available.names}"]

database_name           = "${var.DATABASE_NAME}"

master_username         = "${var.MASTER_USERNAME}"

master_password         = "${var.MASTER_PASSWORD}"

backup_retention_period = 7

preferred_backup_window = "07:00-09:00"

skip_final_snapshot     = "true"

apply_immediately       = "true"

vpc_security_group_ids  = ["${var.VPC_SECURITY_GROUP_IDS}"]

db_subnet_group_name    = "${var.DB_SUBNET_GROUP_NAME}"

tags {

  Name         = "${var.ENVIRONMENT_NAME}-Aurora-DB-Cluster"

  ManagedBy    = "${var.MANAGER}"

  Environment  = "${var.ENVIRONMENT_NAME}"

}

}