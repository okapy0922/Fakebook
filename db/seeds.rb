10.times do |n|
  email = Faker::Internet.email
  password = "password"
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: "テスト"
               )
end

n = 1
while n <= 10
  Blog.create(
    title: "あああ",
    content: "いいいいいいい",
    user_id: n
  )
  n = n + 1
end
