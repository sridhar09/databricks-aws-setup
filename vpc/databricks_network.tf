resource "databricks_mws_networks" "this" {
  provider           = databricks.mws
  account_id         = var.databricks_account_id
  network_name       = "${var.prefix}-network"
  security_group_ids = [aws_security_group.databricks-sg.id]
  subnet_ids         = [aws_subnet.public.id]
  vpc_id             = aws_vpc.main.id
}