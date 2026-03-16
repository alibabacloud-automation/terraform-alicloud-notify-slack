# Basic Example

This example creates a basic Slack notification setup with:

- MNS topic for receiving messages
- FC function for sending notifications to Slack
- Minimal configuration

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

3. Test by publishing a message to the MNS topic:
```bash
# Use Alibaba Cloud Console or CLI to publish a test message
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | Alibaba Cloud region | `string` | `"cn-hangzhou"` | no |
| mns_topic_name | Name of the MNS topic | `string` | `"slack-notifications-basic"` | no |
| slack_webhook_url | Slack webhook URL | `string` | n/a | yes |
| slack_channel | Slack channel name | `string` | `"notifications"` | no |
| slack_username | Slack username for notifications | `string` | `"alicloud-notifier"` | no |

## Outputs

| Name | Description |
|------|-------------|
| mns_topic_name | The name of the created MNS topic |
| fc_function_name | The name of the FC function |
| fc_service_name | The name of the FC service |
