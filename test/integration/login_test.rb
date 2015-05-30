require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  fixtures :all
  test 'login' do
    get '/login'
    assert_response :success

    post_via_redirect '/session', email: users(:one).email, password: 'abc'
    assert_equal '/tasks', path
    assert_equal 'login success!', flash[:notice]
  end
end
