require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  # Helper method to login a user for system tests
  def login_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_on "Sign in"

    # Wait for redirect to complete - check for either "Echos" or the echo name
    assert_selector "h1", text: /Echos|First echo|Second echo/
  end
end
