# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

locals {
  mns_topic_arn = "acs:mns:${local.region_id}:${local.account_id}:/topics/${var.mns_topic_name}"

  # MNS topic trigger configuration (camelCase keys required by fc-go-sdk)
  mns_trigger_config = merge(
    {
      notifyContentFormat = var.subscription_notify_content_format
      notifyStrategy      = var.subscription_notify_strategy
    },
    var.subscription_filter_tag != "" ? {
      filterTag = var.subscription_filter_tag
    } : {}
  )

  region_id  = data.alicloud_regions.current.regions[0].id
  account_id = data.alicloud_account.current.id

  environment_variables = merge(
    {
      SLACK_WEBHOOK_URL = var.slack_webhook_url
      SLACK_CHANNEL     = var.slack_channel
      SLACK_USERNAME    = var.slack_username
      SLACK_EMOJI       = var.slack_emoji
      LOG_EVENTS        = var.log_events ? "True" : "False"
      LOG_LEVEL         = var.log_level
    },
    var.use_kms_encryption && var.kms_secret_name != null ? {
      KMS_SECRET_NAME = var.kms_secret_name
      USE_KMS         = "true"
    } : {}
  )

}

data "alicloud_account" "current" {}
data "alicloud_regions" "current" {
  current = true
}
