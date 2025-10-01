require "test_helper"

class EchoTest < ActiveSupport::TestCase
  test "#total_dates returns the count of echo dates" do
    echo = echos(:first)
    assert_equal 2, echo.total_dates
  end

  test "#total_dates returns 0 when no echo dates exist" do
    echo = echos(:second)
    assert_equal 0, echo.total_dates
  end
end
