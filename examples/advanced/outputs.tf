# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "mns_topic_name" {
  description = "The name of the created MNS topic"
  value       = module.notify_slack.mns_topic_name
}

output "mns_topic_id" {
  description = "The ID of the MNS topic"
  value       = module.notify_slack.mns_topic_id
}

output "fc_function_name" {
  description = "The name of the FC function"
  value       = module.notify_slack.fc_function_name
}

output "fc_function_arn" {
  description = "The ARN of the FC function"
  value       = module.notify_slack.fc_function_arn
}

output "fc_service_name" {
  description = "The name of the FC service"
  value       = module.notify_slack.fc_service_name
}

output "ram_role_name" {
  description = "The name of the RAM role"
  value       = module.notify_slack.ram_role_name
}

output "sls_project_name" {
  description = "The name of the SLS project"
  value       = module.notify_slack.sls_project_name
}

output "sls_logstore_name" {
  description = "The name of the SLS logstore"
  value       = module.notify_slack.sls_logstore_name
}
