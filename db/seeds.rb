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
