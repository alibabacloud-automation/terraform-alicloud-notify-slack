# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

# MNS Topic
resource "alicloud_message_service_topic" "this" {
  count = var.create_mns_topic ? 1 : 0

  topic_name       = var.mns_topic_name
  max_message_size = var.max_message_size
  enable_logging   = var.enable_logging

  tags = merge(var.tags, var.mns_topic_tags)
}

# RAM Role for FC Service
resource "alicloud_ram_role" "fc" {

  role_name                   = var.ram_role_name
  assume_role_policy_document = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "fc.aliyuncs.com"
        ]
      }
    }
  ],
  "Version": "1"
}
EOF
  description                 = var.ram_role_description
  force                       = true
}

# RAM Policy for FC Function
resource "alicloud_ram_policy" "fc" {

  policy_name     = var.ram_policy_name
  policy_document = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "log:PostLogStoreLogs"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  description     = "Policy for FC function to write logs"
  force           = true
}

# Attach Policy to Role
resource "alicloud_ram_role_policy_attachment" "fc" {

  role_name   = alicloud_ram_role.fc.role_name
  policy_name = alicloud_ram_policy.fc.policy_name
  policy_type = "Custom"
}

# SLS Resources (Optional)
resource "alicloud_log_project" "fc" {
  count = var.create_sls_resources ? 1 : 0

  project_name = var.sls_project_name
  description  = "Log project for FC notify-slack function"
  tags         = var.tags
}

resource "alicloud_log_store" "fc" {
  count = var.create_sls_resources ? 1 : 0

  project_name          = alicloud_log_project.fc[0].project_name
  logstore_name         = var.sls_logstore_name
  shard_count           = 2
  auto_split            = true
  max_split_shard_count = 64
  retention_period      = var.sls_logstore_retention_days
}

# FC Service
resource "alicloud_fc_service" "this" {

  name        = var.fc_service_name
  description = "Service for sending notifications to Slack"
  role        = alicloud_ram_role.fc.arn

  dynamic "log_config" {
    for_each = var.create_sls_resources ? [1] : []
    content {
      project                 = alicloud_log_project.fc[0].project_name
      logstore                = alicloud_log_store.fc[0].logstore_name
      enable_instance_metrics = true
      enable_request_metrics  = true
    }
  }

  tags = merge(var.tags, var.fc_service_tags)

  depends_on = [
    alicloud_ram_role_policy_attachment.fc
  ]
}

# FC Function
resource "alicloud_fc_function" "notify_slack" {

  service     = alicloud_fc_service.this.name
  name        = var.fc_function_name
  description = var.fc_function_description
  filename    = var.function_package_path
  memory_size = tostring(var.fc_memory_size)
  runtime     = var.fc_runtime
  handler     = var.fc_handler
  timeout     = var.fc_timeout

  environment_variables = local.environment_variables
}

# FC Trigger for MNS Topic
resource "alicloud_fc_trigger" "mns" {

  service  = alicloud_fc_service.this.name
  function = alicloud_fc_function.notify_slack.name
  name     = "${var.mns_topic_name}-trigger"
  type     = "mns_topic"

  source_arn = local.mns_topic_arn
  role       = alicloud_ram_role.fc.arn

  config_mns = jsonencode(local.mns_trigger_config)

  lifecycle {
    ignore_changes = [
      config_mns
    ]
  }

  depends_on = [
    alicloud_message_service_topic.this
  ]
}
