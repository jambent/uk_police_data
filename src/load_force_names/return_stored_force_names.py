import os
from dotenv import load_dotenv 
import boto3
import json

load_dotenv()


LANDING_BUCKET = os.environ['S3_LANDING_ID']


def return_stored_force_names():
    """
    Returns force names currently stored in S3 bucket
    
    Returns:
        Dictionary of stored force names data
    """
    client = boto3.client('s3')
    stored_force_names = client.get_object(
        Bucket=LANDING_BUCKET, Key='force_names.json')

    stored_force_names_json = stored_force_names['Body'].read().decode(
        'utf-8')
    stored_force_names_dict = json.loads(stored_force_names_json)

    return stored_force_names_dict


if __name__ == "__main__":
    stored_force_names_dict = return_stored_force_names()
    print(stored_force_names_dict)

