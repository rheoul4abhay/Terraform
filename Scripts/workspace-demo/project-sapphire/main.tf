module "payroll_app" {
  source     = "../modules/payroll-app"
  app_region = var.region[terraform.workspace]
  ami        = var.ami[terraform.workspace]
}