def lambda_handler(event, context):
    if 'order_id' not in event or 'product_id' not in event:
        raise Exception("Invalid order format")
    return event