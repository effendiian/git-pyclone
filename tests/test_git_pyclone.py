import pytest


def test_pytest():
    """
    Assert pytest is installed and can run tests.
    """
    assert True


def test_exception():
    """
    Assert exception testing works.
    """
    with pytest.raises(ZeroDivisionError):
        1 / 0
