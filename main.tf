variable rds_sg_id {}
variable "dbname" {
  default = "default"
  description = "Name of this RDS instance" 
}
variable "rds_vpc_id" {
  default = "vpc-XXXXXXXX"
  description = "Our default RDS virtual private cloud (rds_vpc)."
}
variable "rds_public_subnet_group" {
  default = "default-vpc-XXXXXXXX"
  description = "Apparently the group name, according to the RDS launch wizard."
}
variable "storage" {
  default = "256"
  description = "Storage for this RDS instance in GBs"
}
variable "backup_retention" {
  default = "7"
  description = "How long in days to retain backups"
}
variable "skip_final_snapshot" {
  default = true
  description = "Should a snapshot be skipped on deletion"
}
variable "engine_type" {
  default = "postgres"
  description = "Which DB type RDS should run"
}
variable "engine_version" {
  default = "10.11"
  description = "Which version of the DB should RDS run"
}
variable "instance_size" {
  default = "db.m4.large"
  description = "Size of instance to run DB on"
}
variable "multi_az" {
  default = false
  description = "Should RDS live in multiple AZs"
}
variable "username" {
  default = "adminuser"
  description = "User name to access RDS"
}
variable "password" {
  default = "PASSWORD123123123"
  description = "Password to access RDS"
}
varaiable "port" {
  default = "5432"
  description = "Port for access to RDS"
}
variable "public_access" {
  default = true
  description = "Should outside of VPC access be allowed"
}
resource "aws_db_instance" "default" {
  allocated_storage        = var.storage
  backup_retention_period  = var.backup_retention
  db_subnet_group_name     = var.rds_public_subnet_group
  skip_final_snapshot      = var.skip_final_snapshot
  engine                   = var.engine_type
  engine_version           = var.engine_version
  identifier               = var.dbname
  instance_class           = var.instance_size
  multi_az                 = var.multi_az
  name                     = var.dbname
  username                 = var.username
  password                 = var.password
  port                     = var.port
  publicly_accessible      = var.public_access
  storage_encrypted        = true # you should always do this
  storage_type             = "gp2"
  vpc_security_group_ids   = [var.rds_sg_id]
}

