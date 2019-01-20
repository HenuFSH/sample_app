require 'test_helper'

class UsersSigupTest < ActionDispatch::IntegrationTest
  test "invalid sigup information" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, params: { user: { name: "",
                                           email: "user@invalid",
                                           password: "foo",
                                           password_confirmation: "bar" } }
  	end
  	assert_template 'users/new'
  	assert_select "div#error_explanation"
  	assert_select "div.field_with_errors"
  end
  test "valid sigup information" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post users_path, params: { user: { name: "Simon",
                                           email: "18317894179@163.com",
                                           password: "abc123_",
                                           password_confirmation: "abc123_" } }
  	end
  	follow_redirect!
  	assert_template 'users/show'
  	assert_not flash.empty?
  	assert is_logged_in?
  end
end
