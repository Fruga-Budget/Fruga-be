# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(user_name: 'testuser', password: 'test123456', password_confirmation: 'test123456')
advice_1 = user.advices.create!(
  needs: [
    { name: 'Rent', cost: 1500, description: 'Monthly rent payment', isNegotiable: false },
    { name: 'Utilities', cost: 200, description: 'Electricity, water, etc.', isNegotiable: false }
  ],
  wants: [
    { name: 'Dining Out', cost: 300, description: 'Eating out at restaurants' },
    { name: 'Movies', cost: 50, description: 'Monthly movie nights' }
  ],
  savings: [
    { name: '401k', cost: 500, description: 'Retirement savings' },
    { name: 'Emergency Fund', cost: 100, description: 'Emergency savings' }
  ],
  total_income: 3000,
  needs_total: 1700,
  wants_total: 350,
  savings_total: 600,
  recommendation: 'Consider reducing dining out expenses to increase savings.'
)
advice_2 = user.advices.create!(
  needs: [
    { name: 'Groceries', cost: 500, description: 'Monthly grocery shopping', isNegotiable: true },
    { name: 'Insurance', cost: 200, description: 'Health insurance', isNegotiable: false }
  ],
  wants: [
    { name: 'Travel', cost: 400, description: 'Annual vacation savings' },
    { name: 'Gym', cost: 100, description: 'Monthly gym membership' }
  ],
  savings: [
    { name: 'Investments', cost: 300, description: 'Stock investments' },
    { name: 'Savings Account', cost: 200, description: 'General savings' }
  ],
  total_income: 3500,
  needs_total: 700,
  wants_total: 500,
  savings_total: 500,
  recommendation: 'Increase contributions to the savings account to build a stronger emergency fund.'
)
puts 'Seeded Successfully'