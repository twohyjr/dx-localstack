# Setup the aws provider to point to localstack at localhost:4566
provider "aws" {
  region = "us-east-1"
  access_key = "123"
  secret_key = "xyz"
  skip_credentials_validation = true
  skip_requesting_account_id = true
  skip_metadata_api_check = true
  s3_force_path_style = true
  endpoints {
    lambda = "http://localhost:4566"
    iam    = "http://localhost:4566"
  }
}

# Create a policy for the lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  policy =  file("iam/lambda-policy.json")
  role =    aws_iam_role.lambda_role.id

}

# create a role for the lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = file("iam/lambda-assume-policy.json")
}

# zip up the current lambda file
data "archive_file" "lambda_zip" {
    type          = "zip"
    output_path   = "zips/dummy.zip"

    source {
      content = "hello"
      filename = "index.js"
    }
}

# create the lambda called helloworld
resource "aws_lambda_function" "helloworld" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "helloworld"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "nodejs6.10"
}