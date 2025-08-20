require "application_system_test_case"

class SnagsTest < ApplicationSystemTestCase
  setup do
    @snag = snags(:one)
  end

  test "visiting the index" do
    visit snags_url
    assert_selector "h1", text: "Snags"
  end

  test "should create snag" do
    visit snags_url
    click_on "New snag"

    fill_in "Created by", with: @snag.created_by
    fill_in "Description", with: @snag.description
    fill_in "Location", with: @snag.location
    fill_in "Project", with: @snag.project_id
    click_on "Create Snag"

    assert_text "Snag was successfully created"
    click_on "Back"
  end

  test "should update Snag" do
    visit snag_url(@snag)
    click_on "Edit this snag", match: :first

    fill_in "Created by", with: @snag.created_by
    fill_in "Description", with: @snag.description
    fill_in "Location", with: @snag.location
    fill_in "Project", with: @snag.project_id
    click_on "Update Snag"

    assert_text "Snag was successfully updated"
    click_on "Back"
  end

  test "should destroy Snag" do
    visit snag_url(@snag)
    click_on "Destroy this snag", match: :first

    assert_text "Snag was successfully destroyed"
  end
end
