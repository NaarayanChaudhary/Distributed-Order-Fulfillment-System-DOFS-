provider "aws" {
  region = "us-east-1"
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

module "lambdas" {
  source = "./modules/lambdas"
}

module "stepfunctions" {
  source = "./modules/stepfunctions"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "sqs" {
  source = "./modules/sqs"
}