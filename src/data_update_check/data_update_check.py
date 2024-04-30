from get_json_response import get_json_response
from get_last_updated_date import get_last_updated_date


URL = "https://data.police.uk/api/crime-last-updated"


def lambda_handler(event, context):
    """
    Lambda handler function for data update check
    """
    response_status, response_body = get_json_response(URL)
    last_updated_date = get_last_updated_date()
    if response_status == 200 and response_body['date'] != last_updated_date:
        return {'statusCode': 200}
