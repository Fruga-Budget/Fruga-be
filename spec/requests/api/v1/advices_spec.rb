require 'rails_helper'


RSpec.describe AdviceGenerator, type: :service do
  let(:total_income) { 5000 }
  let(:needs) do
    [
      { 'name' => 'Rent', 'cost' => 2000, 'description' => 'Monthly rent payment', 'isNegotiable' => false },
      { 'name' => 'Utilities', 'cost' => 500, 'description' => 'Electricity, water, etc.', 'isNegotiable' => true },
      { 'name' => 'Groceries', 'cost' => 500, 'description' => 'Monthly groceries', 'isNegotiable' => true }
    ]
  end
  let(:wants) do
    [
      { 'name' => 'Dining Out', 'cost' => 500, 'description' => 'Eating out at restaurants' },
      { 'name' => 'Entertainment', 'cost' => 1000, 'description' => 'Movies, concerts, etc.' }
    ]
  end
  let(:savings) do
    [
      { 'name' => '401k', 'cost' => 200, 'description' => 'Retirement savings' },
      { 'name' => 'Savings Account', 'cost' => 800, 'description' => 'General savings' }
    ]
  end

  subject { described_class.new(total_income, needs, wants, savings) }

  describe '#check_to_call_api', vcr: true do
    it 'returns a recommendation when budget does not meet the 50/30/20 rule' do
      VCR.use_cassette('generate_advice') do
        result = subject.check_to_call_api
        expect(result).to include("The user's current budget breakdown does not align with the 50/30/20 rule.")
        expect(result).to include("Revised Budget Breakdown based on 50/30/20 rule:")
        expect(result).to include("By making these adjustments, the user can better align their budget with the recommended 50/30/20 rule.")
      end
    end

    it 'returns a success message when budget meets the 50/30/20 rule' do
      VCR.use_cassette('dont_generate_advice') do
        total_income = 10000
        needs = [
          { 'name' => 'Rent', 'cost' => 2000, 'description' => 'Monthly rent payment', 'isNegotiable' => false },
          { 'name' => 'Utilities', 'cost' => 1500, 'description' => 'Electricity, water, etc.', 'isNegotiable' => true },
          { 'name' => 'Groceries', 'cost' => 1500, 'description' => 'Monthly groceries', 'isNegotiable' => true }
        ]
        wants = [
          { 'name' => 'Dining Out', 'cost' => 1500, 'description' => 'Eating out at restaurants' },
          { 'name' => 'Entertainment', 'cost' => 1500, 'description' => 'Movies, concerts, etc.' }
        ]
        savings = [
          { 'name' => '401k', 'cost' => 2000, 'description' => 'Retirement savings' }
        ]

        service = described_class.new(total_income, needs, wants, savings)
        result = service.check_to_call_api
        expect(result).to include("Congratulations, you're on the right track for the 50/30/20 rule of budgeting!")
      end
    end
  end
end

RSpec.describe "Advices API", type: :request do

  describe "GET /api/v1/users/:user_id/advices" do
    it "gets all of a user's advices - empty", vcr: true do
      user = User.create!(user_name: 'Nico', password: 'password123', password_confirmation: 'password123')

      get "/api/v1/users/#{user.id}/advices", headers: { "Content-Type": "application/json" }
      
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a (Hash)
      expect(json_response).to have_key (:data)
      expect(json_response[:data]).to be_a (Array)
      expect(json_response[:data].empty?).to eq (true)
    end

    it "gets all of a user's advices - no user", vcr: true do
      get "/api/v1/users/1/advices", headers: { "Content-Type": "application/json" }

      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a (Hash)
      expect(json_response).to have_key (:error)
      expect(json_response[:error]).to be_a (String)
      expect(json_response[:error]).to eq ('User not found')
    end
  end

  describe "POST /api/v1/users/:user_id/advices" do
    let!(:user) do
      User.find_or_create_by!(
        user_name: "Nico"
      ) do |user|
        user.password = "password123"
        user.password_confirmation = "password123"
      end
    end

    let(:valid_params) do
      {
        advice: {
          total_income: 5000,
          needs: [
            { name: "Rent", cost: 1500, isNegotiable: false, description: "Monthly rent payment" },
            { name: "Utilities", cost: 300, isNegotiable: true, description: "Electricity, water, etc." }
          ],
          wants: [
            { name: "Gym Membership", cost: 50, description: "Monthly gym membership" },
            { name: "Dining Out", cost: 200, description: "Eating out at restaurants" }
          ],
          savings: [
            { name: "Emergency Fund", cost: 500, description: "Emergency savings fund" },
            { name: "Retirement", cost: 300, description: "Retirement savings" }
          ]
        }
      }
    end

    it "creates advice and returns the expected response", vcr: { cassette_name: 'create_advice' } do
      post "/api/v1/users/#{user.id}/advices", params: valid_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:attributes][:total_income]).to eq(5000)
      expect(json_response[:data][:attributes][:expenses][:needs].size).to eq(2)
      expect(json_response[:data][:attributes][:expenses][:wants].size).to eq(2)
      expect(json_response[:data][:attributes][:expenses][:savings].size).to eq(2)
      expect(json_response[:data][:attributes][:advice]).not_to be_empty
    end
  end
end
