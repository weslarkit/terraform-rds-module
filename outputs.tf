output "rds_instance_endpoint" {
  value = "postgres://adminuser:PASSWORD123123123@${aws_db_instance.default.endpoint}/${var.dbname}"
}
