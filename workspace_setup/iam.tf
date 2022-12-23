//A cross-account IAM role is registered with the databricks_mws_credentials resource.

data "databricks_aws_assume_role_policy" "this" {
  external_id = var.databricks_account_id
}

data "databricks_aws_crossaccount_policy" "this" {}

resource "aws_iam_role" "cross_account_role" {
  name               = "${var.prefix}-databricks-${var.workspace_name}-crossaccount"
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  tags               = var.default_tags
}

resource "aws_iam_role_policy" "this" {
  name   = "${aws_iam_role.cross_account_role.name}-policy"
  role   = aws_iam_role.cross_account_role.id
  policy = data.databricks_aws_crossaccount_policy.this.json
}

