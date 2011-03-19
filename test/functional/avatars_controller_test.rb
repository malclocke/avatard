require 'test_helper'

class AvatarsControllerTest < ActionController::TestCase

  def setup
    @avatar = Factory.create :avatar
    @avatar_params = Factory.attributes_for(:avatar, :email => 'other@example.com')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert assigns(:avatars)
    assert assigns(:avatar)
  end

  test "should get show" do
    get :show, :id => @avatar.to_param
    assert_response :success
    assert_equal @avatar, assigns(:avatar)
  end

  test "should get show in png format" do
    get :show, :id => @avatar.to_param, :format => :png
    assert_equal @avatar, assigns(:avatar)
    assert_redirected_to @avatar.avatar.thumb(Avatar.dimensions).url
  end

  test "should redirect to default image for unknown avatars" do
    unknown_checksum = Digest::MD5.hexdigest('notfound@example.com')
    get :show, :id => unknown_checksum
    assert_redirected_to "http://#{request.host_with_port}/images/default.png"
  end

  test "should create an avatar" do
    assert_difference 'Avatar.count' do
      post :create, :avatar => @avatar_params
    end
  end
end
