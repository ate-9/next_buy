USERS_SEEDS = [
  { id: 1, name: 'seed_user', email_address: 'test@example.com', password: 'passw0rd', icon_color: '#737380' },
]

USERS_SEEDS.each do |seed_user|
  User.find_or_create_by!(name: seed_user[:name]) do |u|
    u.email_address = seed_user[:email_address]
    u.password = seed_user[:password]
    u.icon_color = seed_user[:icon_color]
  end
  puts "新規ユーザー name: #{seed_user[:name]} を作成しました"
end
