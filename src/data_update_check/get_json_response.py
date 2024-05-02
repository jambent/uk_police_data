import requests


def get_json_response(url):
    """
    Returns response status code, and response body in JSON format
    """
    if not isinstance(url, str):
        raise TypeError("Input URL must be a string")

    try:
        response = requests.get(url)
        json_body = response.json()
        return response.status_code, json_body
    except BaseException:
        return response.status_code, "Exception: JSON decoding failed"

