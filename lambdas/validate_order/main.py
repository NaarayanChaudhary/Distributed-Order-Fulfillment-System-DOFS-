import json
import boto3
import os

sfn = boto3.client('stepfunctions')
STATE_MACHINE_ARN = os.environ['STEP_FUNCTION_ARN']

def lambda_handler(event, context):
    for record in event['Records']:
        order = json.loads(record['body'])
        if 'orderId' in order and 'item' in order:
            sfn.start_execution(
                stateMachineArn=STATE_MACHINE_ARN,
                input=json.dumps(order)
            )
        else:
            print(f"Invalid order received: {order}")
