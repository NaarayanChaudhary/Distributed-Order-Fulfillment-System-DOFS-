import json
import boto3
import os

sqs = boto3.client('sqs')
VALIDATION_QUEUE_URL = os.environ['VALIDATION_QUEUE_URL']

def lambda_handler(event, context):
    body = json.loads(event['body'])
    response = sqs.send_message(
        QueueUrl=VALIDATION_QUEUE_URL,
        MessageBody=json.dumps(body)
    )
    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Order received and sent for validation'})
    }
