# Advanced Example

This example demonstrates an advanced Slack notification setup with:

- MNS topic with custom message size limit
- FC function with increased memory and timeout
- SLS logging enabled with 30-day retention
- Custom retry strategy and message filtering
- Detailed tagging strategy
- Debug-level logging

## Features

- **Enhanced Performance**: 1GB memory, 60s timeout
- **Logging**: Full SLS integration with 30-day retention
- **Reliability**: Exponential backoff retry strategy
- **Filtering**: Message filtering by tag
- **Monitoring**: Debug-level logging enabled
- **Organization**: Comprehensive tagging

## Usage

1. Set your Slack webhook URL:
```bash
export TF_VAR_slack_webhook_url="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
```

2. Initialize and apply:
```bash
terraform init
terraform plan
terraform apply
```

3. Destroy resources when done:
```bash
terraform destroy
```

## Cost

Using this module will create resources that incur costs. Estimate costs before deployment:
- MNS Topic: Based on message volume and retention
- Function Compute: Based on execution time and memory (1GB configuration)
- SLS Project and Logstore: Based on storage and retention (30-day retention)
- RAM roles and policies: No direct cost

Refer to [Alibaba Cloud Pricing](https://www.alibabacloud.com/pricing) for details.

## Testing

Test by publishing a message with filter tag:
```json
{
  "text": "Production alert message",
  "tag": "important"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | Alibaba Cloud region | `string` | `"cn-hangzhou"` | no |
| mns_topic_name | Name of the MNS topic | `string` | `"slack-notifications-advanced"` | no |
| slack_webhook_url | Slack webhook URL | `string` | n/a | yes |
| slack_channel | Slack channel name | `string` | `"production-alerts"` | no |
| slack_username | Slack username for notifications | `string` | `"alicloud-production"` | no |

## Outputs

| Name | Description |
|------|-------------|
| mns_topic_name | The name of the created MNS topic |
| mns_topic_id | The ID of the MNS topic |
| fc_function_name | The name of the FC function |
| fc_function_arn | The ARN of the FC function |
| fc_service_name | The name of the FC service |
| ram_role_name | The name of the RAM role |
| sls_project_name | The name of the SLS project |
| sls_logstore_name | The name of the SLS logstore |

## Notes

- This configuration is suitable for production environments
- SLS logs can be queried for troubleshooting
- Exponential backoff provides better retry behavior under load
- Message filtering reduces unnecessary notifications
