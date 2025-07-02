ITEMS_SEEDS = [
# TODO: itemsのseeds準備
  # { id: 1, name: 'seed_item', price: 1234, lists: 1, bought: false },
]

ITEMS_SEEDS.each do |seed_item|
  Item.find_or_create_by!(name: seed_item[:name], list: seed_item[:list], bought: seed_item[:bought]).tap do |u|
    puts "新規ユーザー name: #{u.name} を作成しました"
  end
end
