require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "dep1" do
    #p "in UserTest the truth"
    @user = users(:tianming)
    @skill = skills(:ruby)
    @user.add_skill(@skill)
    @user.get_logger
    assert @user.has_skill?(@skill)
  end

  test "dep2" do
    #p "in UserTest the truth"
    UsersController.new.get_logger
    assert true
  end
end
