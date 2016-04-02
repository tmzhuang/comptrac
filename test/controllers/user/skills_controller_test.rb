require 'test_helper'

class User::SkillsControllerTest < ActionController::TestCase
  setup do
    @user_skill = user_skills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_skills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_skill" do
    assert_difference('User::Skill.count') do
      post :create, user_skill: {  }
    end

    assert_redirected_to user_skill_path(assigns(:user_skill))
  end

  test "should show user_skill" do
    get :show, id: @user_skill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_skill
    assert_response :success
  end

  test "should update user_skill" do
    patch :update, id: @user_skill, user_skill: {  }
    assert_redirected_to user_skill_path(assigns(:user_skill))
  end

  test "should destroy user_skill" do
    assert_difference('User::Skill.count', -1) do
      delete :destroy, id: @user_skill
    end

    assert_redirected_to user_skills_path
  end
end
