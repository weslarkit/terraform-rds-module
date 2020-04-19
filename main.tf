variable rds_sg_id {}
variable "rds_vpc_id" {
  default = "vpc-XXXXXXXX"
  description = "Our default RDS virtual private cloud (rds_vpc)."
}
variable "rds_public_subnet_group" {
  default = "default-vpc-XXXXXXXX"
  description = "Apparently the group name, according to the RDS launch wizard."
}
variable "dbname" {}

resource "aws_db_instance" "default" {
  allocated_storage        = 256 # gigabytes
  backup_retention_period  = 7   # in days
  db_subnet_group_name     = var.rds_public_subnet_group
  skip_final_snapshot      = true
  engine                   = "postgres"
  engine_version           = "10.11"
  identifier               = var.dbname
  instance_class           = "db.m4.large"
  multi_az                 = false
  name                     = var.dbname
# parameter_group_name     = "mydbparamgroup1" # if you have tuned it
  password                 = "PASSWORD123123123"
  port                     = 5432
  publicly_accessible      = true
  storage_encrypted        = true # you should always do this
  storage_type             = "gp2"
  username                 = "adminuser"
  vpc_security_group_ids   = [var.rds_sg_id]
}

