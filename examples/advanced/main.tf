# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

provider "alicloud" {
  region = var.region
}

module "notify_slack" {
  source = "../.."

  mns_topic_name   = var.mns_topic_name
  max_message_size = 32768
  enable_logging   = true

  fc_service_name       = "slack-notify-advanced"
  fc_function_name      = "notify_slack_advanced"
  fc_memory_size        = 1024
  fc_timeout            = 60
  function_package_path = "${path.module}/functions/code.zip"

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username
  slack_emoji       = ":rocket:"

  log_events = true
  log_level  = "DEBUG"

  create_sls_resources        = true
  sls_logstore_retention_days = 30

  subscription_notify_strategy       = "EXPONENTIAL_DECAY_RETRY"
  subscription_notify_content_format = "JSON"
  subscription_filter_tag            = "important"

  tags = {
    Environment = "production"
    Terraform   = "true"
    Project     = "slack-notifications"
  }

  mns_topic_tags = {
    Service = "messaging"
  }

  fc_service_tags = {
    Service = "compute"
  }
}
