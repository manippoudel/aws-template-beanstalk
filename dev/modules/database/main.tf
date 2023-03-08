resource "aws_db_instance" "database" {
  identifier                = "${var.project_name}-${var.env}-rds"
  allocated_storage         = 10
  db_name                   = "${var.project_name}${var.env}rds"
  engine                    = var.db_engine
  engine_version            = var.db_engine_version
  instance_class            = var.db_instance_class
  username                  = "${var.project_name}${var.env}user"
  password                  = var.db_password
  max_allocated_storage     = 30
  db_subnet_group_name      = var.aws_db_subnet_group_id
  vpc_security_group_ids    = [var.rds_sg_id]
  final_snapshot_identifier = "${var.project_name}-${var.env}-rds-snapshot"
  tags = {
    "name" = "${var.project_name}-${var.env}-rds"
  }
}
