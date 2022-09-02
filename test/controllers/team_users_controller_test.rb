require "test_helper"

class TeamUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_user = team_users(:one)
  end

  test "should get index" do
    get team_users_url
    assert_response :success
  end

  test "should get new" do
    get new_team_user_url
    assert_response :success
  end

  test "should create team_user" do
    assert_difference("TeamUser.count") do
      post team_users_url, params: { team_user: { team_id: @team_user.team_id, user_id: @team_user.user_id } }
    end

    assert_redirected_to team_user_url(TeamUser.last)
  end

  test "should show team_user" do
    get team_user_url(@team_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_user_url(@team_user)
    assert_response :success
  end

  test "should update team_user" do
    patch team_user_url(@team_user), params: { team_user: { team_id: @team_user.team_id, user_id: @team_user.user_id } }
    assert_redirected_to team_user_url(@team_user)
  end

  test "should destroy team_user" do
    assert_difference("TeamUser.count", -1) do
      delete team_user_url(@team_user)
    end

    assert_redirected_to team_users_url
  end
end
