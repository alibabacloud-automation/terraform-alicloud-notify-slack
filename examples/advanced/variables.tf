# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

variable "region" {
  description = "Alibaba Cloud region"
  type        = string
  default     = "cn-hangzhou"
}

variable "mns_topic_name" {
  description = "Name of the MNS topic"
  type        = string
  default     = "slack-notifications-advanced"
}

variable "slack_webhook_url" {
  description = "Slack webhook URL"
  type        = string
  sensitive   = true
  default     = "https://hooks.slack.com/services/PLACEHOLDER/PLACEHOLDER/PLACEHOLDER"
}

variable "slack_channel" {
  description = "Slack channel name"
  type        = string
  default     = "production-alerts"
}

variable "slack_username" {
  description = "Slack username for notifications"
  type        = string
  default     = "alicloud-production"
}
