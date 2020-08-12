require 'open-uri'
require 'json'

# Dose.delete_all
Dose.delete_all
Ingredient.delete_all
Cocktail.delete_all

puts "Cleaning DB"

puts 'Creating 5 cocktails...'
5.times do |i|
  cocktail = Cocktail.create!(
    name: Faker::Beer.name,
    description_drink: Faker::Lorem.paragraph
  )
  puts "#{i + 1}. #{cocktail.name}"
end
puts 'Finished Cocktails!'

puts "Creating Ingredients..."

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
serialized_ingredients = open(url).read
ingredients = JSON.parse(serialized_ingredients)

ingredients['drinks'].each do |ing|
  i = Ingredient.create!(name: ing['strIngredient1'])
  puts "create #{i.name}"
end

# Ingredient.create!(name: 'lemon')
# Ingredient.create!(name: 'mint')
# Ingredient.create!(name: 'ice')
# Ingredient.create!(name: 'gin')
# Ingredient.create!(name: 'lime')
# Ingredient.create!(name: 'mint leaves')
# Ingredient.create!(name: 'vodka')
# Ingredient.create!(name: 'rum')
# Ingredient.create!(name: 'pineapple juice')
# Ingredient.create!(name: 'orange juice')
# Ingredient.create!(name: 'triple sec')
# Ingredient.create!(name: 'cognac')
# Ingredient.create!(name: 'pomegranate')
# Ingredient.create!(name: 'egg white')
# Ingredient.create!(name: 'grand marnier liquer')
# Ingredient.create!(name: 'elderflower liquer')
# Ingredient.create!(name: 'milk')
# Ingredient.create!(name: 'amaretto')
# Ingredient.create!(name: 'runny honey')



puts "Finished ingredients"

# puts 'Creating 10 dosages...'
# 10.times do |i|
#   cocktail = Cocktail.find(rand(1..5))
#   dose = Dose.create!(
#     description: Faker::Food.measurement,
#     cocktail_id: cocktail.id,
#     ingredient_id: rand(20)
#   )
#   puts "#{i + 1}. #{dose.cocktail_id}"
# end
# puts 'Finished dosages'
puts 'All done!'
