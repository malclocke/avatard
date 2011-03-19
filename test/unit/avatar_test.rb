require 'test_helper'

class AvatarTest < ActiveSupport::TestCase
  def setup
    @avatar = Factory.create :avatar
  end

  test "should not save without email" do
    @avatar.email = ''
    assert !@avatar.save
  end

  test "should set a checksum of the users email" do
    assert_equal '55502f40dc8b7c769880b10874abc9d0', @avatar.checksum
  end

  test "email should be unique" do
    avatar = Factory.build :avatar
    avatar.email = @avatar.email
    assert_no_difference 'Avatar.count' do
      assert !avatar.save
    end
  end
end
