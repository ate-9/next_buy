USERS_SEEDS = [
  { id: 1, name: 'seed_user', password: "passw0rd", icon_color: "#737380" },
]

USERS_SEEDS.each do |seed_user|
  User.find_or_create_by!(name: seed_user[:name], password: seed_user[:password]).tap do |u|
    puts "新規ユーザー name: #{u.name} を作成しました"
  end
end
