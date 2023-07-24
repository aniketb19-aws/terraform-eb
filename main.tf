data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_cloudwatch_event_rule" "ebrule" {
  for_each = toset(var.buses)
  #name=each.key
  event_bus_name = each.value
  event_pattern = jsonencode({
    account = [
      local.account_id
    ]
  })
  is_enabled = true
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "event_bus_invoke_central_event_bus" {
  name               = "event-bus-invoke-central-event-bus"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "event_bus_invoke_central_event_bus_policy" {
  statement {
    effect    = "Allow"
    actions   = ["events:PutEvents"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "event_bus_invoke_central_event_bus" {
  name   = "event_bus_invoke_central_event_bus_policy"
  policy = data.aws_iam_policy_document.event_bus_invoke_central_event_bus_policy.json
}

resource "aws_iam_role_policy_attachment" "event_bus_invoke_central_event_bus" {
  role       = aws_iam_role.event_bus_invoke_central_event_bus.name
  policy_arn = aws_iam_policy.event_bus_invoke_central_event_bus.arn
}

output "all_rules" {
  value = aws_cloudwatch_event_rule.ebrule
}

output "ebRole" {
  value = aws_iam_role.event_bus_invoke_central_event_bus.arn
}

module "central_eventbridge" {
  providers = {
    aws = aws.central
  }
  source = "terraform-aws-modules/eventbridge/aws"

  bus_name = "central-event-bus"

  tags = {
    Name = "my-bus"
  }
}

resource "aws_cloudwatch_event_target" "EBtargets" {
  for_each       = tomap(aws_cloudwatch_event_rule.ebrule)
  event_bus_name = each.key
  rule           = each.value.name
  arn            = module.central_eventbridge.eventbridge_bus_arn
  role_arn       = aws_iam_role.event_bus_invoke_central_event_bus.arn
}
