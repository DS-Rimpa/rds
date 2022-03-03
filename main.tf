resource "aws_db_instance" "default" {
  allocated_storage = 20
  identifier = "testinstance"
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.m4.large"
  name = "test"
  username = "admin"
  password = "admin5536"
  parameter_group_name = "default.mysql5.7"
  deletion_protection     = false
  publicly_accessible = true
}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "private_subnet1" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}
resource "aws_subnet" "private_subnet2" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
}
resource "aws_db_subnet_group" "dbsubnet" {
  name = "db_subnet_group"
  subnet_ids = ["${aws_subnet.private_subnet1.id}", "${aws_subnet.private_subnet2.id}"]
}