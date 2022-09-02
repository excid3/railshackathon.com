require "application_system_test_case"

class TeamUsersTest < ApplicationSystemTestCase
  setup do
    @team_user = team_users(:one)
  end

  test "visiting the index" do
    visit team_users_url
    assert_selector "h1", text: "Team users"
  end

  test "should create team user" do
    visit team_users_url
    click_on "New team user"

    fill_in "Team", with: @team_user.team_id
    fill_in "User", with: @team_user.user_id
    click_on "Create Team user"

    assert_text "Team user was successfully created"
    click_on "Back"
  end

  test "should update Team user" do
    visit team_user_url(@team_user)
    click_on "Edit this team user", match: :first

    fill_in "Team", with: @team_user.team_id
    fill_in "User", with: @team_user.user_id
    click_on "Update Team user"

    assert_text "Team user was successfully updated"
    click_on "Back"
  end

  test "should destroy Team user" do
    visit team_user_url(@team_user)
    click_on "Destroy this team user", match: :first

    assert_text "Team user was successfully destroyed"
  end
end
