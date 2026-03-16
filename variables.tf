# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

variable "create_mns_topic" {
  description = "Whether to create new MNS topic"
  type        = bool
  default     = true
}

# MNS Topic Configuration
variable "mns_topic_name" {
  description = "The name of the MNS topic to create"
  type        = string
}

variable "max_message_size" {
  description = "The maximum length of the message sent to the topic, unit: bytes"
  type        = number
  default     = 65536
}

variable "enable_logging" {
  description = "Whether to enable MNS topic logging"
  type        = bool
  default     = false
}

# Function Compute Configuration
variable "fc_service_name" {
  description = "The name of the FC service"
  type        = string
  default     = "notify-slack-service"
}

variable "fc_function_name" {
  description = "The name of the FC function to create"
  type        = string
  default     = "notify_slack"
}

variable "fc_function_description" {
  description = "The description of the FC function"
  type        = string
  default     = "Send notifications to Slack via webhook"
}

variable "fc_runtime" {
  description = "FC function runtime"
  type        = string
  default     = "python3.10"
}

variable "fc_handler" {
  description = "The entry point of the function"
  type        = string
  default     = "index.handler"
}

variable "fc_timeout" {
  description = "Function timeout in seconds"
  type        = number
  default     = 30
}

variable "fc_memory_size" {
  description = "Function memory size in MB"
  type        = number
  default     = 512
}

# Slack Configuration
variable "slack_webhook_url" {
  description = "The URL of Slack webhook"
  type        = string
  sensitive   = true
}

variable "slack_channel" {
  description = "The name of the channel in Slack for notifications"
  type        = string
}

variable "slack_username" {
  description = "The username that will appear on Slack messages"
  type        = string
}

variable "slack_emoji" {
  description = "A custom emoji that will appear on Slack messages"
  type        = string
  default     = ":alibabacloud:"
}

# MNS Subscription Configuration
variable "subscription_notify_strategy" {
  description = "Subscription notify strategy"
  type        = string
  default     = "BACKOFF_RETRY"
}

variable "subscription_notify_content_format" {
  description = "Subscription notify content format"
  type        = string
  default     = "JSON"
}

variable "subscription_filter_tag" {
  description = "The tag used to filter messages"
  type        = string
  default     = ""
}

# Logging Configuration
variable "log_events" {
  description = "Boolean flag to enable or disable logging of incoming events"
  type        = bool
  default     = false
}

variable "log_level" {
  description = "Logging level for the function"
  type        = string
  default     = "INFO"
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "mns_topic_tags" {
  description = "Additional tags for the MNS topic"
  type        = map(string)
  default     = {}
}

variable "fc_service_tags" {
  description = "Additional tags for the FC service"
  type        = map(string)
  default     = {}
}

# RAM Role Configuration
variable "ram_role_name" {
  description = "The name of the RAM role"
  type        = string
  default     = "notify-slack-role"
}

variable "ram_role_description" {
  description = "Description for the RAM role"
  type        = string
  default     = "Role for FC function to send notifications to Slack"
}

variable "ram_policy_name" {
  description = "The name of the RAM policy"
  type        = string
  default     = "notify-slack-policy"
}

# KMS Configuration (Optional)
variable "kms_secret_name" {
  description = "KMS secret name for decrypting Slack webhook URL"
  type        = string
  default     = null
  sensitive   = true
}

variable "use_kms_encryption" {
  description = "Whether to use KMS encryption for webhook URL"
  type        = bool
  default     = false
}

# SLS Configuration (Optional)
variable "create_sls_resources" {
  description = "Whether to create SLS logging resources"
  type        = bool
  default     = false
}

variable "sls_project_name" {
  description = "SLS log project name"
  type        = string
  default     = "notify-slack-logs"
}

variable "sls_logstore_name" {
  description = "SLS logstore name"
  type        = string
  default     = "fc-notify-slack-logs"
}

variable "sls_logstore_retention_days" {
  description = "SLS logstore retention period in days"
  type        = number
  default     = 7
}

variable "function_package_path" {
  description = "The path to the function code package"
  type        = string
  default     = null
}
