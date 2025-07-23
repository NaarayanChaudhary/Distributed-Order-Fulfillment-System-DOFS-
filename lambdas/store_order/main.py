import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
TABLE_NAME = os.environ['DYNAMODB_TABLE']
table = dynamodb.Table(TABLE_NAME)

def lambda_handler(event, context):
    order = event  # Input from Step Function
    table.put_item(Item=order)
    return {
        'status': 'stored',
        'orderId': order.get('orderId')
    }
 