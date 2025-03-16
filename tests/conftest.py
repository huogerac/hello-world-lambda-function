import os
import sys

import pytest

sys.path.insert(0, os.path.abspath(os.path.dirname(os.path.dirname(__file__))))


class MockContext:
    function_name = "test_function"


@pytest.fixture
def lambda_context():
    return MockContext()
