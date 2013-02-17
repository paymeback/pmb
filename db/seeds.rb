# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Exchange.create(name: "USD", value: 3.3)

#Create AdminUser
u = User.create({"email" => "admin@pmb.dev","password" => "adminpmb","password_confirmation" => "adminpmb","nickname" => "admin"})
u.add_role :admin
u.save

#Create Users
3.times do |i|

	
end
