# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

provider "alicloud" {
  region = var.region
}

module "notify_slack" {
  source = "../.."

  mns_topic_name = var.mns_topic_name

  function_package_path = "${path.module}/functions/code.zip"

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username

  tags = {
    Environment = "test"
    Terraform   = "true"
  }
}
