# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "seedの実行を開始"

olivia = User.find_or_create_by!(email: "olivia@gameil.com") do |user|
  user.name = "Olivia"
  user.password = "olivia24"
end

admin = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "管理者"
  user.password = "#{ENV['SECRET_KEY']}"
end

puts "seedの実行が完了しました"