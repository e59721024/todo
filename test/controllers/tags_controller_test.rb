require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    @user = Users(:one)
    @task = @user.tasks.first
    @tag = Tag.create(name: 'existing')
    session[:user_id] = @user.id
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test 'should create new Tag' do
    assert_difference("Tag.count") do
      post :create, user_id: @user, task_id: @task.id, name: 'Name'
    end
    assert_response :redirect
    assert_equal 'Name', @task.tags.first.name
    assert_redirected_to user_task_path(@user, @task)
  end

  test 'should assign existing Tag' do
    assert_no_difference("Tag.count") do
      post :create, user_id: @user, task_id: @task.id, name: @tag.name
    end
    assert_response :redirect
    assert_equal @tag.name, @task.tags.first.name
    assert_redirected_to user_task_path(@user, @task)
  end

  test 'should not assign already assigned Tag' do
    @task.tags << @tag
    assert_no_difference("@task.tags.count") do
      post :create, user_id: @user, task_id: @task.id, name: @tag.name
    end
    assert_response :redirect
    assert_redirect user_task_path(@user, @task)
  end

  test 'should not create blank-named Tag' do
    assert_no_difference("@task.tags.count") do
      post :create, user_id: @user, task_id: @task.id, name: ''
    end
    assert_response :redirect
    assert_redirected_to user_task_path(@user, @task)
  end

  test 'should destroy assigned Tag' do
    @task.tags << @tag
    assert_difference("@task.tags.count", -1) do
      post :destroy, user_id: @user, task_id: @task.id, name: @tag.name
    end
    assert_response :redirect
    assert_redirected_to user_task_path(@user, @task)
  end

  test 'should not destroy not-assigned Tag' do
    assert_no_difference("@task.tags.count") do
      post :destroy, user_id: @user, task_id: @task.id, name: @tag.name
    end
    assert_response :redirect
    assert_redirected_to user_task_path(@user, @task)
  end
end
