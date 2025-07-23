resource "aws_apigatewayv2_api" "http_api" {
  name          = "order-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.api_handler_invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "order_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /order"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}