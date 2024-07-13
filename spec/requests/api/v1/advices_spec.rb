require 'rails_helper'

RSpec.describe AdviceGenerator, type: :service do
  let(:total_income) { 5000 }
  let(:needs) do
    [
      { 'name' => 'Rent', 'cost' => 2000 },
      { 'name' => 'Utilities', 'cost' => 500 },
      { 'name' => 'Groceries', 'cost' => 500 }
    ]
  end
  let(:wants) do
    [
      { 'name' => 'Dining Out', 'cost' => 500 },
      { 'name' => 'Entertainment', 'cost' => 1000 }
    ]
  end
  let(:savings) { 500 }

  subject { described_class.new(total_income, needs, wants, savings) }

  describe '#check_to_call_api' do
    it 'returns a recommendation when budget does not meet the 50/30/20 rule' do
      result = subject.check_to_call_api
      expect(result).to include('Your monthly budget breakdown does not meet the 50/30/20 rule.')
    end

    it 'returns a success message when budget meets the 50/30/20 rule' do
      total_income = 10000
      needs = [
        { 'name' => 'Rent', 'cost' => 2000 },
        { 'name' => 'Utilities', 'cost' => 500 },
        { 'name' => 'Groceries', 'cost' => 500 }
      ]
      wants = [
        { 'name' => 'Dining Out', 'cost' => 1000 },
        { 'name' => 'Entertainment', 'cost' => 300 }
      ]
      savings = 2000

      service = described_class.new(total_income, needs, wants, savings)
      result = service.check_to_call_api
      expect(result).to include('Your budget meets the 50/30/20 rule.')
    end
  end
end