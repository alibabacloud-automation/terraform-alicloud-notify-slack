阿里云 Notify Slack Terraform 模块

# terraform-alicloud-notify-slack

[English](https://github.com/alibabacloud-automation/terraform-alicloud-notify-slack/blob/main/README.md) | 简体中文

该 Terraform 模块创建一个 [MNS（消息服务）](https://www.alibabacloud.com/help/zh/mns/) 主题和一个阿里云[函数计算](https://www.alibabacloud.com/help/zh/fc/) 函数，通过 [incoming webhooks API](https://api.slack.com/incoming-webhooks) 向 Slack 发送通知。支持创建新的 MNS 主题或使用现有主题，可选的 SLS 日志集成，以及 KMS 加密 webhook URL。

## 使用方法

首先在 Slack 工作区设置 [incoming webhook 集成](https://my.slack.com/services/new/incoming-webhook/)，然后按以下方式使用模块：

```terraform
module "notify_slack" {
  source = "alibabacloud-automation/notify-slack/alicloud"

  mns_topic_name = "slack-topic"

  slack_webhook_url = "https://hooks.slack.com/services/AAA/BBB/CCC"
  slack_channel     = "alicloud-notification"
  slack_username    = "reporter"
}
```

## 示例

* [基础示例](https://github.com/alibabacloud-automation/terraform-alicloud-notify-slack/tree/main/examples/basic)
* [高级示例](https://github.com/alibabacloud-automation/terraform-alicloud-notify-slack/tree/main/examples/advanced)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.188.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.188.0 |
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_fc_function.notify_slack](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fc_function) | resource |
| [alicloud_fc_service.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fc_service) | resource |
| [alicloud_fc_trigger.mns](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fc_trigger) | resource |
| [alicloud_log_project.fc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.fc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [alicloud_message_service_topic.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_topic) | resource |
| [alicloud_ram_policy.fc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.fc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.fc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [local_file.function_code](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |
| [archive_file.function_package](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_mns_topic"></a> [create\_mns\_topic](#input\_create\_mns\_topic) | Whether to create new MNS topic | `bool` | `true` | no |
| <a name="input_create_sls_resources"></a> [create\_sls\_resources](#input\_create\_sls\_resources) | Whether to create SLS logging resources | `bool` | `false` | no |
| <a name="input_custom_function_code"></a> [custom\_function\_code](#input\_custom\_function\_code) | Custom Python code for the Lambda function. If not provided, default code will be used | `string` | `null` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Whether to enable MNS topic logging | `bool` | `false` | no |
| <a name="input_fc_function_description"></a> [fc\_function\_description](#input\_fc\_function\_description) | The description of the FC function | `string` | `"Send notifications to Slack via webhook"` | no |
| <a name="input_fc_function_name"></a> [fc\_function\_name](#input\_fc\_function\_name) | The name of the FC function to create | `string` | `"notify_slack"` | no |
| <a name="input_fc_handler"></a> [fc\_handler](#input\_fc\_handler) | The entry point of the function | `string` | `"index.handler"` | no |
| <a name="input_fc_memory_size"></a> [fc\_memory\_size](#input\_fc\_memory\_size) | Function memory size in MB | `number` | `512` | no |
| <a name="input_fc_runtime"></a> [fc\_runtime](#input\_fc\_runtime) | FC function runtime | `string` | `"python3.10"` | no |
| <a name="input_fc_service_name"></a> [fc\_service\_name](#input\_fc\_service\_name) | The name of the FC service | `string` | `"notify-slack-service"` | no |
| <a name="input_fc_service_tags"></a> [fc\_service\_tags](#input\_fc\_service\_tags) | Additional tags for the FC service | `map(string)` | `{}` | no |
| <a name="input_fc_timeout"></a> [fc\_timeout](#input\_fc\_timeout) | Function timeout in seconds | `number` | `30` | no |
| <a name="input_kms_secret_name"></a> [kms\_secret\_name](#input\_kms\_secret\_name) | KMS secret name for decrypting Slack webhook URL | `string` | `null` | no |
| <a name="input_log_events"></a> [log\_events](#input\_log\_events) | Boolean flag to enable or disable logging of incoming events | `bool` | `false` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Logging level for the function | `string` | `"INFO"` | no |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | The maximum length of the message sent to the topic, unit: bytes | `number` | `65536` | no |
| <a name="input_mns_topic_name"></a> [mns\_topic\_name](#input\_mns\_topic\_name) | The name of the MNS topic to create | `string` | n/a | yes |
| <a name="input_mns_topic_tags"></a> [mns\_topic\_tags](#input\_mns\_topic\_tags) | Additional tags for the MNS topic | `map(string)` | `{}` | no |
| <a name="input_ram_policy_name"></a> [ram\_policy\_name](#input\_ram\_policy\_name) | Custom name for the RAM policy. If not provided, it will be auto-generated | `string` | `null` | no |
| <a name="input_ram_role_description"></a> [ram\_role\_description](#input\_ram\_role\_description) | Description for the RAM role | `string` | `"Role for FC function to send notifications to Slack"` | no |
| <a name="input_ram_role_name"></a> [ram\_role\_name](#input\_ram\_role\_name) | Custom name for the RAM role. If not provided, it will be auto-generated | `string` | `null` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | The name of the channel in Slack for notifications | `string` | n/a | yes |
| <a name="input_slack_emoji"></a> [slack\_emoji](#input\_slack\_emoji) | A custom emoji that will appear on Slack messages | `string` | `":alibabacloud:"` | no |
| <a name="input_slack_username"></a> [slack\_username](#input\_slack\_username) | The username that will appear on Slack messages | `string` | n/a | yes |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | The URL of Slack webhook | `string` | n/a | yes |
| <a name="input_sls_logstore_name"></a> [sls\_logstore\_name](#input\_sls\_logstore\_name) | SLS logstore name | `string` | `"fc-notify-slack-logs"` | no |
| <a name="input_sls_logstore_retention_days"></a> [sls\_logstore\_retention\_days](#input\_sls\_logstore\_retention\_days) | SLS logstore retention period in days | `number` | `7` | no |
| <a name="input_sls_project_name"></a> [sls\_project\_name](#input\_sls\_project\_name) | SLS log project name. If not provided, it will be auto-generated | `string` | `null` | no |
| <a name="input_subscription_filter_tag"></a> [subscription\_filter\_tag](#input\_subscription\_filter\_tag) | The tag used to filter messages | `string` | `""` | no |
| <a name="input_subscription_notify_content_format"></a> [subscription\_notify\_content\_format](#input\_subscription\_notify\_content\_format) | Subscription notify content format | `string` | `"JSON"` | no |
| <a name="input_subscription_notify_strategy"></a> [subscription\_notify\_strategy](#input\_subscription\_notify\_strategy) | Subscription notify strategy | `string` | `"BACKOFF_RETRY"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_use_kms_encryption"></a> [use\_kms\_encryption](#input\_use\_kms\_encryption) | Whether to use KMS encryption for webhook URL | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fc_function_arn"></a> [fc\_function\_arn](#output\_fc\_function\_arn) | The ARN of the FC function |
| <a name="output_fc_function_id"></a> [fc\_function\_id](#output\_fc\_function\_id) | The ID of the FC function |
| <a name="output_fc_function_name"></a> [fc\_function\_name](#output\_fc\_function\_name) | The name of the FC function |
| <a name="output_fc_service_id"></a> [fc\_service\_id](#output\_fc\_service\_id) | The ID of the FC service |
| <a name="output_fc_service_name"></a> [fc\_service\_name](#output\_fc\_service\_name) | The name of the FC service |
| <a name="output_fc_trigger_id"></a> [fc\_trigger\_id](#output\_fc\_trigger\_id) | The ID of the FC MNS trigger |
| <a name="output_mns_topic_id"></a> [mns\_topic\_id](#output\_mns\_topic\_id) | The ID of the MNS topic |
| <a name="output_mns_topic_name"></a> [mns\_topic\_name](#output\_mns\_topic\_name) | The name of the MNS topic |
| <a name="output_ram_role_arn"></a> [ram\_role\_arn](#output\_ram\_role\_arn) | The ARN of the RAM role used by FC function |
| <a name="output_ram_role_name"></a> [ram\_role\_name](#output\_ram\_role\_name) | The name of the RAM role used by FC function |
| <a name="output_sls_logstore_name"></a> [sls\_logstore\_name](#output\_sls\_logstore\_name) | The name of the SLS logstore |
| <a name="output_sls_project_name"></a> [sls\_project\_name](#output\_sls\_project\_name) | The name of the SLS project |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
