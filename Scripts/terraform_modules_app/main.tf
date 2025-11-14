module "dev-infra" {
  source              = "./infra-app"
  env                 = "dev"
  bucket_name         = "infra-app-bucket-ft.abhay"
  dynamodb_table_name = "infra-app-dynamodb-ft.abhay"
  hash_key            = "studentID"
  ec2_ami_id          = "ami-03695d52f0d883f65" # Amazon Linux
  ec2_instance_type   = "t2.micro"
  ec2_instance_count  = 1
}

module "stag-infra" {
  source              = "./infra-app"
  env                 = "stag"
  bucket_name         = "infra-app-bucket-ft.abhay"
  dynamodb_table_name = "infra-app-dynamodb-ft.abhay"
  hash_key            = "studentID"
  ec2_ami_id          = "ami-02b8269d5e85954ef" # Ubuntu
  ec2_instance_type   = "t2.small"
  ec2_instance_count  = 1
}

module "prod-infra" {
  source              = "./infra-app"
  env                 = "prod"
  bucket_name         = "infra-app-bucket-ft.abhay"
  dynamodb_table_name = "infra-app-dynamodb-ft.abhay"
  hash_key            = "studentID"
  ec2_ami_id          = "ami-02b8269d5e85954ef" # Ubuntu
  ec2_instance_type   = "t2.medium"
  ec2_instance_count  = 1
}