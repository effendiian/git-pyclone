import pytest


class TestCoverage:
    """
    Test pytest module to ensure tests can be run.
    """

    def test_pytest(self):
        """
        Assert pytest is installed and can run tests.
        """
        assert True

    def test_exception(self):
        """
        Assert exception testing works.
        """
        with pytest.raises(ZeroDivisionError):
            1 / 0
