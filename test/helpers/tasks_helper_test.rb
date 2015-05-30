#coding: utf-8
require 'test_helper'

class TasksHelperTest <ActionView::TestCase
  test 'should be low' do
    assert_equal priority_name(0 ), '低'
  end
end
