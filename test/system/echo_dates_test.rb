require "application_system_test_case"

class EchoDatesTest < ApplicationSystemTestCase
  setup do
    # Login as a teacher to access all echoes
    login_as users(:math_teacher)
    @echo = Echo.ordered.first
    @echo_date = @echo.echo_dates.first

    visit echo_path(@echo)
  end

  test "Creating a new echo date" do
    assert_selector "h1", text: @echo.name

    click_on "New date"
    assert_selector "h1", text: @echo.name

    fill_in "Date", with: Date.current + 1.day
    click_on "Create date"

    assert_selector "h1", text: @echo.name
    assert_text I18n.l(Date.current + 1.day, format: :long)

    # Verify total is updated
    assert_text "Total Dates:"
    assert_text @echo.reload.total_dates.to_s
  end

  test "Updating an echo date" do
    skip "No echo dates available" unless @echo_date

    assert_selector "h1", text: @echo.name

    within id: nested_dom_id(@echo, @echo_date) do
      click_on "Edit"
    end
    assert_selector "h1", text: @echo.name

    fill_in "Date", with: Date.current + 2.days
    click_on "Update date"

    assert_text I18n.l(Date.current + 2.days, format: :long)
  end

  test "Destroying an echo date" do
    skip "No echo dates available" unless @echo_date

    assert_text I18n.l(@echo_date.date, format: :long)

    accept_confirm do
      within id: nested_dom_id(@echo, @echo_date) do
        click_on "Delete"
      end
    end

    assert_no_text I18n.l(@echo_date.date, format: :long)

    # Verify total is updated
    assert_text "Total Dates:"
    assert_text @echo.reload.total_dates.to_s
  end

  test "Form validation errors are displayed" do
    click_on "New date"
    assert_selector "h1", text: @echo.name

    # Submit form without filling required fields
    click_on "Create date"

    assert_text "Date can't be blank"
  end

  test "Turbo frames work correctly for nested resources" do
    # Test that the nested_dom_id helper creates unique IDs
    click_on "New date"

    # The form should appear in the correct Turbo Frame
    assert_selector "##{nested_dom_id(@echo, EchoDate.new)} form"

    # Fill and submit the form
    fill_in "Date", with: Date.current + 3.days
    click_on "Create date"

    # The new date should appear in the echo_dates Turbo Frame
    within "##{nested_dom_id(@echo, 'echo_dates')}" do
      assert_text I18n.l(Date.current + 3.days, format: :long)
    end
  end

  private

  def nested_dom_id(*args)
    args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join("_")
  end
end
