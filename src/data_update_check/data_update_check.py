from get_json_response import get_json_response
from get_last_updated_date import get_stored_last_updated_date
from update_last_updated_date import update_last_updated_date


URL = "https://data.police.uk/api/crime-last-updated"


def lambda_handler(event, context):
    """
    Lambda handler function for data update check
    """
    response_status, response_body = get_json_response(URL)
    last_pipeline_update_date = get_stored_last_updated_date()
    available_last_update_date = response_body['date']
    if (response_status == 200 
    and available_last_update_date != last_pipeline_update_date):
        update_response = update_last_updated_date(available_last_update_date)
        return {'statusCode': 200}, update_response
