provider "aws" {
  region = "us-east-1"
}

# Parámetro en AWS Parameter Store
resource "aws_ssm_parameter" "app_message" {
  name  = "/demo/app/message"
  type  = "String"
  value = "Hola desde Parameter Store 🚀"
}

# IAM Role (para la app)
resource "aws_iam_role" "app_role" {
  name = "demo-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Permisos para leer Parameter Store
resource "aws_iam_role_policy" "ssm_policy" {
  name = "ssm-read-policy"
  role = aws_iam_role.app_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}
