require "application_system_test_case"

class EchoesTest < ApplicationSystemTestCase
  setup do
    # Login as a teacher to access all echoes
    login_as users(:math_teacher)
    # We need to order echo as well in the system tests
    @echo = Echo.ordered.first
  end

  test "Showing an echo" do
    visit echos_path
    click_link @echo.name

    assert_selector "h1", text: @echo.name
  end

  test "Creating a new echo" do
    visit echos_path
    assert_selector "h1", text: "Echos"

    click_on "New echo"
    fill_in "Name", with: "Capybara echo"

    assert_selector "h1", text: "Echos"
    click_on "Create echo"

    assert_selector "h1", text: "Echos"
    assert_text "Capybara echo"
  end

  test "Updating an echo" do
    visit echos_path
    assert_selector "h1", text: "Echos"

    within id: dom_id(@echo) do
      click_on "Edit"
    end
    fill_in "Name", with: "Updated echo"

    assert_selector "h1", text: "Echos"
    click_on "Update echo"

    assert_selector "h1", text: "Echos"
    assert_text "Updated echo"
  end

  test "Destroying an echo" do
    visit echos_path
    assert_text @echo.name

    within id: dom_id(@echo) do
      click_on "Delete"
    end
    assert_no_text @echo.name
  end
end
