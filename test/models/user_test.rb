require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    #p "in UserTest the truth"
    @user = users(:tianming)
    @skill = skills(:ruby)
    @user.add_skill(@skill)
    @user.register(:tianming)
    assert @user.has_skill?(@skill)
  end
end
