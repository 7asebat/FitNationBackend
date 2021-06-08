# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(name: "Youssef Walid", user_auth: UserAuth.new(email: "admin@fitnation.com", password: "password", role: ::UserAuth.roles[:admin]))
Client.create(name: "Ahmed Nasser", user_auth: UserAuth.new(email: "client@fitnation.com", password: "password", role: ::UserAuth.roles[:client]))
Trainer.create(name: "Ahmed Hisham", user_auth: UserAuth.new(email: "trainer@fitnation.com", password: "password", role: ::UserAuth.roles[:trainer]))
Nutritionist.create(name: "Abdelrahman Farid", user_auth: UserAuth.new(email: "nutritionist@fitnation.com", password: "password", role: ::UserAuth.roles[:nutritionist]))

exercises = JSON.parse(File.read("db/seeds/exercises/exercises.json")).with_indifferent_access[:exercises]
exercises.each do |u|
  exercise = Exercise.create(name: u[:name], meta_data: u[:meta_data], tips: u[:tips])
  if File.exists?("db/seeds/exercises/videos/#{u[:id]}.mp4")
    exercise.clip.attach(io: File.open("db/seeds/exercises/videos/#{u[:id]}.mp4"), filename: "#{u[:id]}.mp4", content_type: "video/mp4")
  end
end

foods = JSON.parse(File.read("db/seeds/food/food.json"))

foods.each_with_index do |u, i|
  name = u["Food and Serving"].split(',').first
  quantity = u["Food and Serving"].split(',').second&.strip

  type = u["Food Type"]

  nutrition_facts = {
    calories: u["Calories"],
    sodium: u["Sodium"],
    potassium: u["Potassium"],
    carbs: u["Total Carbo-hydrate"],
    fibers: u["Dietary Fiber"],
    sugar: u["Sugars"],
    protein: u["Protein"],
    vitaminA: u["Vitamin A"],
    vitaminC: u["Vitamin C"],
    calcium: u["Calcium"],
    iron: u["Iron"],
    quantity: quantity
  }

  food = Food.create(name: name, nutrition_facts: nutrition_facts, food_type: ::Food.food_types[type])
  food.image.attach(io: File.open("db/seeds/food/images/#{i+1}.jpg"), filename: "#{i+1}.jpg", content_type: "image/jpeg")
end
