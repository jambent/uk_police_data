import json

from return_stored_force_names import return_stored_force_names
from check_for_force_names_change import check_for_force_names_change
from get_json_response import get_json_response
from update_force_names import update_force_names


URL = "https://data.police.uk/api/forces"


def lambda_handler(event, context):
    """
    Lambda handler function for force names update check
    """
    stored_force_names = return_stored_force_names()
    response_status, response_body = get_json_response(URL)

    force_names_change_check_results = check_for_force_names_change(
        stored_force_names, response_body)

    if (response_status == 200
        and force_names_change_check_results["number_of_force_names"]
            != "No change"):
        update_response = update_force_names(response_body)
        return update_response

    elif (response_status == 200
            and force_names_change_check_results["number_of_force_names"]
            == "No change"):
        return {
            'statusCode': 200,
            'body': json.dumps(
                "No change to force names list")}

    else:
        return {
            'statusCode': 400,
            'body': json.dumps(f"Failed to retrieve force names from {URL}")
        }
