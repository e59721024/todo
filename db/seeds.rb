# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Task.delete_all
User.create! do |u|
  u.name = 'alex'
  u.email = 'alex@mail.com'
  u.password = 'alex'
  u.birthday = '1999-12-31'
  u.adm = true
end

user = User.create(
  name: 'ben',
  birthday: 20.years.ago,
  email: 'ben@mail.com',
  password: 'ben',
  adm: false)
Task.create(:user => user, :name => 'study', :deadline => 1.days.since, :priority => 1)
Task.create(:user => user, :name => 'reading', :deadline => 2.days.since, :priority => 2)

