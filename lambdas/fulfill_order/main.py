import random
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('orders')
failed_table = dynamodb.Table('failed_orders')

def lambda_handler(event, context):
    for record in event['Records']:
        order = record['body']
        if random.random() < 0.7:
            # Success
            table.update_item(
                Key={'order_id': order['order_id']},
                UpdateExpression="set status=:s",
                ExpressionAttributeValues={':s': 'FULFILLED'}
            )
        else:
            # Failure
            failed_table.put_item(Item=order)