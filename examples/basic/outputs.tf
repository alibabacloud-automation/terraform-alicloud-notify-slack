# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "mns_topic_name" {
  description = "The name of the created MNS topic"
  value       = module.notify_slack.mns_topic_name
}

output "fc_function_name" {
  description = "The name of the FC function"
  value       = module.notify_slack.fc_function_name
}

output "fc_service_name" {
  description = "The name of the FC service"
  value       = module.notify_slack.fc_service_name
}
