# -*- coding: utf-8 -*-
import json
import logging
import os
import urllib.request
import urllib.error

logger = logging.getLogger()
logger.setLevel(os.environ.get('LOG_LEVEL', 'INFO'))

def handler(event, context):
    try:
        evt = json.loads(event) if isinstance(event, str) else event
        logger.info(f"Received event: {json.dumps(evt)}")

        webhook_url = os.environ.get('SLACK_WEBHOOK_URL')
        channel = os.environ.get('SLACK_CHANNEL')
        username = os.environ.get('SLACK_USERNAME')
        emoji = os.environ.get('SLACK_EMOJI', ':alibabacloud:')

        if not webhook_url:
            raise ValueError("SLACK_WEBHOOK_URL environment variable is not set")

        message_body = evt.get('Message', evt.get('body', ''))
        if isinstance(message_body, str):
            try:
                message_data = json.loads(message_body)
            except json.JSONDecodeError:
                message_data = {'text': message_body}
        else:
            message_data = message_body

        slack_payload = {
            'channel': channel,
            'username': username,
            'icon_emoji': emoji,
            'text': message_data.get('text', json.dumps(message_data, ensure_ascii=False))
        }

        if 'attachments' in message_data:
            slack_payload['attachments'] = message_data['attachments']

        req = urllib.request.Request(
            webhook_url,
            data=json.dumps(slack_payload).encode('utf-8'),
            headers={'Content-Type': 'application/json'},
            method='POST'
        )

        with urllib.request.urlopen(req, timeout=10) as response:
            status_code = response.getcode()
            logger.info(f"Slack response status: {status_code}")

            if status_code != 200:
                raise Exception(f"Slack API returned status {status_code}")

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Notification sent successfully'})
        }

    except Exception as e:
        logger.error(f"Error sending notification: {str(e)}", exc_info=True)
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
