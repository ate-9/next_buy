LISTS_SEEDS = [
  # TODO: listのseeds準備
  # { id: 1, list_name: 'seed_list', author: 1, draft: false },
]

LISTS_SEEDS.each do |seed_list|
  List.find_or_create_by!(list_name: seed_list[:list_name], author: seed_list[:author]).tap do |u|
    puts "新規リスト list_name: #{u.list_name} を作成しました"
  end
end
