puts "#{Rails.env}環境のseedsを流します"

# 各環境のseedsを流す
Dir[Rails.root.join("db/seeds", Rails.env, "*.rb")].sort.each do |file|
  puts "Seeding: #{File.basename(file, '.rb')}..."
  load file
end
