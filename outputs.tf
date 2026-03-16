# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "mns_topic_name" {
  description = "The name of the MNS topic"
  value       = try(alicloud_message_service_topic.this[0].topic_name, var.mns_topic_name)
}

output "mns_topic_id" {
  description = "The ID of the MNS topic"
  value       = try(alicloud_message_service_topic.this[0].id, null)
}

output "fc_trigger_id" {
  description = "The ID of the FC MNS trigger"
  value       = alicloud_fc_trigger.mns.id
}

output "fc_service_name" {
  description = "The name of the FC service"
  value       = alicloud_fc_service.this.name
}

output "fc_service_id" {
  description = "The ID of the FC service"
  value       = alicloud_fc_service.this.id
}

output "fc_function_name" {
  description = "The name of the FC function"
  value       = alicloud_fc_function.notify_slack.name
}

output "fc_function_id" {
  description = "The ID of the FC function"
  value       = alicloud_fc_function.notify_slack.id
}

output "fc_function_arn" {
  description = "The ARN of the FC function"
  value       = alicloud_fc_function.notify_slack.function_id
}

output "ram_role_arn" {
  description = "The ARN of the RAM role used by FC function"
  value       = alicloud_ram_role.fc.arn
}

output "ram_role_name" {
  description = "The name of the RAM role used by FC function"
  value       = alicloud_ram_role.fc.role_name
}

output "sls_project_name" {
  description = "The name of the SLS project"
  value       = try(alicloud_log_project.fc[*].project_name[0], null)
}

output "sls_logstore_name" {
  description = "The name of the SLS logstore"
  value       = try(alicloud_log_store.fc[*].logstore_name[0], null)
}
