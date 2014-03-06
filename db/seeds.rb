
# Temporary admin account
u = User.new(
    username: "admin",
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
# u.skip_confirmation!
u.save!

# for n in 1..200 do
#         name = Faker::Name.first_name
#         email = Faker::Internet.email 
#         User.create!(username: name, email: email, password: "password", password_confirmation: "password")
# end

# User.all.each do |user|
# 	for i in 1..10
# 		@band_id = "#{i}"
# 		b = UserFan.create(user_id: user.id, band_id: @band_id)
# 	end
# end

