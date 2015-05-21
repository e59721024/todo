# coding: utf-8
module TasksHelper
  def priority_name(priority)
    { 0 => '低', 1 => '中', 2 => '高' }[priority]
  end
end
