import pytest

from src.data_update_check.get_json_response import get_json_response


def test_that_status_200_and_json_returned_with_correct_url():
    url = "https://data.police.uk/api/crime-last-updated"
    response_status, response_body = get_json_response(url)

    assert response_status == 200
    assert isinstance(response_body, dict)
    assert 'date' in response_body


def test_that_status_404_and_except_message_returned_for_invalid_url():
    url = "https://data.police.uk/api/crime-last-updates"
    response_status, response_body = get_json_response(url)

    assert response_status == 404
    assert response_body == "Exception: JSON decoding failed"


def test_that_type_error_raised_if_url_not_a_string():
    with pytest.raises(TypeError, match="Input URL must"):
        get_json_response(8944)
