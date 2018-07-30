resource "aws_api_gateway_rest_api" "user" {
  name = "${var.role}-stnsserver"
  description = "stns server"
}

resource "aws_api_gateway_usage_plan" "user" {
  name = "my_usage_plan"
  description  = "my description"
  api_stages {
    api_id = "${aws_api_gateway_rest_api.user.id}"
    stage  = "${aws_api_gateway_deployment.user.stage_name}"
  }
}

resource "aws_api_gateway_api_key" "user" {
  name = "${aws_api_gateway_rest_api.user.name}"
}

resource "aws_api_gateway_usage_plan_key" "user" {
  key_id        = "${aws_api_gateway_api_key.user.id}"
  key_type      = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.user.id}"
}

resource "aws_api_gateway_deployment" "user" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  stage_name = "prod"

  depends_on = ["aws_api_gateway_method.user_name","aws_api_gateway_method.group_name"]
}

resource "aws_api_gateway_resource" "user" {
  rest_api_id = "${aws_api_gateway_rest_api.user.id}"
  parent_id = "${aws_api_gateway_rest_api.user.root_resource_id}"
  path_part = "user"
}
