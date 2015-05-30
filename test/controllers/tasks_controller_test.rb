# coding: utf-8
require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  fixtures :tasks
  setup do
    session[:user_id] = users(:one).id
  end
  test "should get new" do
    get :new
    assert_response :success
  end
  test 'should get edit' do
    get :edit, id: users(:one)
    assert_response :success
  end
  test 'should post create' do
    post :create, task: { name: 'shopping',
                          deadline: 2.days.since,
                          priority: 1 }
    assert_response :redirect
    assert !assigns[:task].new_record?
  end
  test 'should delete destroy' do
    assert_difference('Task.count', -1) do
      delete :destroy, id: tasks(:one)
    end
  end
  test 'should get index' do
    get :index
    assert_response :success
    assert_template :index
    assert_select 'h1', 'Tasks#index'
    assert_select 'table' do |elements|
      assert_select elements.first, 'th', 4
      assert_select 'tr', 3
    end
  end

end
