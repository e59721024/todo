require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'should not save' do
    task = Task.new
    assert !task.save
  end
  test 'should save'do
    task = Task.new(name: 'exercise',
                    deadline: 2.days.since,
                    priority: 1,
                    user: users(:one))
    assert task.save
  end
end
