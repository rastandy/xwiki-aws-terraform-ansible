provider "aws" {
  region = "${var.aws_region}"
}

module "xwiki_service" {
  # When develping
  # source = "/Users/arusso/Development/devops/terraform/modules/xwiki-terraform"
  source = "git@github.com:rastandy/xwiki-terraform.git"

  ## Main settings
  aws_region                            = "${var.aws_region}"
  project                               = "${var.project}"
  service                               = "${var.service}"
  servername                            = "${var.servername}"
  ec2_instance_type                     = "${var.ec2_instance_type}"
  ec2_key_file                          = "${var.ec2_key_file}"
  xwiki_permanent_directory_volume_size = "${var.xwiki_permanent_directory_volume_size}"
  ## XWiki settings
  xwiki_ami            = "${var.xwiki_ami}"
  # xwiki_version      = "${var.xwiki_version}"
  ## Database settings
  db_allocated_storage = "${var.db_allocated_storage}"
  db_instance_type     = "${var.db_instance_type}"
  db_port              = "${var.db_port}"
  db_user              = "${var.db_user}"
  db_password          = "${var.xwiki_database_user_pass}"

  xwiki_permanent_directory_snapshot_id = "${var.xwiki_permanent_directory_snapshot_id}"
  xwiki_db_snapshot_id                  = "${var.xwiki_db_snapshot_id}"

  database_backup_retention_period = "${var.xwiki_database_backup_retention_period}"
}
