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
        expect(result).to_not be(nil)
        expect(result).to include("The user's budget does not match the 50/30/20 rule. Here are specific recommendations:\n\n- Reduce Dining Out by $100 (negotiable)\n- Reduce Entertainment by $100\n- Increase Savings Account by $200\n\nRevised budget breakdown to meet the 50/30/20 rule:\n\n- Needs: $2500 (50%)\n  - Rent: $2000\n  - Utilities: $300\n  - Groceries: $200\n\n- Wants: $2000 (40%)\n  - Dining Out: $400\n  - Entertainment: $900\n\n- Savings: $1000 (20%)\n  - 401k: $200\n  - Savings Account: $800\n\nThis revised budget aligns with the 50/30/20 rule.")
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
