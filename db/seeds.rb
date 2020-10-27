# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Provider.create(name: 'Provider 1', url: 'https://jo3kcwlvke.execute-api.us-west-2.amazonaws.com/dev/provider1')
Provider.create(name: 'Provider 2', url: 'https://jo3kcwlvke.execute-api.us-west-2.amazonaws.com/dev/provider2')