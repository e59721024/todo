# coding: utf-8
module TasksHelper
  def priority_name(priority)
    { 1 => 'Low', 2 => 'Middle', 3 => 'High' }[priority]
  end
end
