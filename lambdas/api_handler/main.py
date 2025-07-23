import json
import boto3

def lambda_handler(event, context):
    body = json.loads(event['body'])
    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Order received', 'order': body})
    }