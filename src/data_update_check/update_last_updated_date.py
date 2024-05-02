import os
import boto3
import json


LANDING_BUCKET = os.environ['S3_LANDING_ID']


def update_last_updated_date(new_date):
    """
    Updates last data update date stored in s3 bucket 
    to currently available date from https://data.police.uk/api

    Args:
        new_date:   Date recovered from 
                    https://data.police.uk/api/crime-last-updated
    Returns:
        update_response:  response meta data from s3 client 
                          put_object operation
    """
    client = boto3.client('s3')
    last_updated_date_object = client.get_object(
        Bucket=LANDING_BUCKET, Key='last_updated_date.json')

    last_updated_date_json = last_updated_date_object['Body'].read().decode(
        'utf-8')
    last_updated_date_dict = json.loads(last_updated_date_json)
    
    last_updated_date_dict["date"] = new_date
    new_last_updated_date_json = json.dumps(last_updated_date_dict)
    
    update_response = client.put_object(Body = new_last_updated_date_json,
                                 Bucket = LANDING_BUCKET,
                                 Key = 'last_updated_date.json')
    
    return update_response





