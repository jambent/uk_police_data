import boto3
import os
import json


def update_force_names(new_force_names_string):
    try:
        s3 = boto3.client("s3", region_name="eu-west-2")
        bucket = os.environ['S3_LANDING_ID']
        body = json.dumps(new_force_names_string)
        (s3.put_object(
            Bucket=bucket,
            Key="force_names.json", Body=body))

        return {
            'statusCode': 200,
            'body': json.dumps(
                "Successfully updated force names list")}

    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps(f"Failed to update force names: {e}")
        }
