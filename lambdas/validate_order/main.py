import json

def lambda_handler(event, context):
    required_fields = ['order_id', 'customer_name', 'items']

    for field in required_fields:
        if field not in event:
            raise ValueError(f"Missing required field: {field}")
    
    return event  # Return the same object for next step
