import os
import boto3
import json


LANDING_BUCKET = os.environ['S3_LANDING_ID']


def get_stored_last_updated_date():
    """
    Returns last data update date stored in s3 bucket
    """
    client = boto3.client('s3')
    last_updated_date_object = client.get_object(
        Bucket=LANDING_BUCKET, Key='last_updated_date.json')

    last_updated_date_json = last_updated_date_object['Body'].read().decode(
        'utf-8')
    last_updated_date_dict = json.loads(last_updated_date_json)

    last_updated_date = last_updated_date_dict["date"]

    return last_updated_date
