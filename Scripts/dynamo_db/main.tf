resource "aws_dynamodb_table" "employees" {
  name         = "employees"
  hash_key     = "employee_id"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "employee_id"
    type = "N"
  }
}

resource "aws_dynamodb_table_item" "new-employee" {
  table_name = aws_dynamodb_table.employees.name
  hash_key   = aws_dynamodb_table.employees.hash_key
  item       = <<EOF
  {
    "employee_id": {"N": "1"},
    "name": {"S": "Jojo Jackson"},
    "age": {"N": "25"},
    "role": {"S": "DevOps Engineer"}
  }
  EOF
}