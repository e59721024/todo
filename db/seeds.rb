# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Task.delete_all
user = User.create(:name => 'a', :birthday => 20.years.ago, :email => 'a')
Task.create(:user => user, :name => 'study', :deadline => 1.days.since, :priority => 1)
Task.create(:user => user, :name => 'reading', :deadline => 2.days.since, :priority => 2)

# user = User.create(:name => 'b', :birthday => 20.years.ago, :email => 'b')
