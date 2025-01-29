# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ['Action', 'Comedy', 'Drama', 'Horror'].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Clearing existing data...'

CombinationRuleValue.destroy_all
CombinationRule.destroy_all
ProductOptionValue.destroy_all
ProductOptionType.destroy_all
OptionValue.destroy_all
OptionType.destroy_all
Product.destroy_all

puts 'Creating products...'
basic_bike = Product.create!(name: 'Basic Bike', description: 'Just a standard bicycle', base_price: 100)
mountain_bike = Product.create!(name: 'Mountain Bike', description: 'An off-road bike with extra features', base_price: 250)

puts 'Creating option types + values...'
frame_type = OptionType.create!(name: 'Frame', description: 'Different frame styles')
full_susp  = OptionValue.create!(option_type: frame_type, name: 'Full-Suspension')
diamond    = OptionValue.create!(option_type: frame_type, name: 'Diamond')

finish_type = OptionType.create!(name: 'Finish', description: 'Paint finish options')
matte       = OptionValue.create!(option_type: finish_type, name: 'Matte')
shiny       = OptionValue.create!(option_type: finish_type, name: 'Shiny')

wheel_type  = OptionType.create!(name: 'Wheels', description: 'Different wheel sets')
road_wheels = OptionValue.create!(option_type: wheel_type, name: 'Road Wheels')
mountain_wheels = OptionValue.create!(option_type: wheel_type, name: 'Mountain Wheels')

basket_type = OptionType.create!(name: 'Basket', description: 'Different types of baskets for the bike')
basket_none  = OptionValue.create!(option_type: basket_type, name: 'None')
basket_wood  = OptionValue.create!(option_type: basket_type, name: 'Wood')
basket_white = OptionValue.create!(option_type: basket_type, name: 'White')

puts 'Linking option types to products...'
[basic_bike, mountain_bike].each do |product|
  [frame_type, finish_type, wheel_type].each do |type|
    ProductOptionType.create!(product: product, option_type: type)
  end
end
ProductOptionType.create!(product: basic_bike, option_type: basket_type) # Only the basic bike has basket

puts 'Linking option values to products (with stock + availability)...'
[basic_bike, mountain_bike].each do |product|
  [full_susp, diamond, matte, shiny, road_wheels, mountain_wheels].each do |ov|
    availability_type = ProductOptionValue.availability_types.keys.sample
    ProductOptionValue.create!(
      product:,
      option_value: ov,
      availability_type:,
      stock: (rand(0..5) if availability_type == 'stock_controlled')
    )
  end
end

[basket_none, basket_wood, basket_white].each do |ov| # Only the basic bike has basket
  availability_type = ProductOptionValue.availability_types.keys.sample
  ProductOptionValue.create!(
    product: basic_bike,
    option_value: ov,
    availability_type:,
    stock: (rand(0..5) if availability_type == 'stock_controlled')
  )
end

puts 'Creating combination rules...'

# 1) A forbidden combination rule for the Basic Bike
#    e.g., 'Diamond Frame + Shiny finish' is not possible on the basic bike.
forbidden_rule = ForbiddenCombinationRule.create!(
  product: basic_bike,
  description: 'Diamond + Shiny finish is forbidden on Basic Bike'
)
CombinationRuleValue.create!(combination_rule: forbidden_rule, option_value: diamond)
CombinationRuleValue.create!(combination_rule: forbidden_rule, option_value: shiny)

# 2) A price modifier rule for the Mountain Bike
#    e.g., 'Full-Suspension + Shiny finish' => +30 EUR
price_rule = PriceModifierCombinationRule.create!(
  product: mountain_bike,
  description: 'Full-susp + shiny => +30 EUR for paint coverage',
  modifier_amount: 30
)
CombinationRuleValue.create!(combination_rule: price_rule, option_value: full_susp)
CombinationRuleValue.create!(combination_rule: price_rule, option_value: shiny)

puts 'Seeding complete!'
