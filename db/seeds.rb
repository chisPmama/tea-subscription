# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'factory_bot_rails'
require 'json'

# Include FactoryBot syntax to use 'create' method
include FactoryBot::Syntax::Methods

tea_titles = File.read("spec/fixtures/tea_products_search.json")
tea_json = JSON.parse(tea_titles, symbolize_names: true)
teas = tea_json[:products]
tea_ids = teas.map{|tea| tea[:id]}

tea_ids.each do |id|
  tea_description = File.read("spec/fixtures/#{id}_search.json")
  tea_json = JSON.parse(tea_description, symbolize_names: true)
  create(:tea, title: tea_json[:title], description: tea_json[:description])
end

@tea1 = Tea.all.first
@tea2 = Tea.all[1]
@tea3 = Tea.all[2]

@customer1 = create(:customer)
@customer2 = create(:customer)
@customer3 = create(:customer)

@subscription1 = FactoryBot.create(:subscription)
@subscription2 = FactoryBot.create(:subscription)
@subscription3 = FactoryBot.create(:subscription)