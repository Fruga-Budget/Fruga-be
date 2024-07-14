require "rails_helper"

RSpec.describe "Python Service", type: :service, vcr: true do
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
  it "exists" do
    service = FastapiService.new

    expect(service).to be_a FastapiService
  end

  describe "#generate_advice" do
    it "returns json response with given input" do
      total_income = 5000

      advice = FastapiService.generate_advice(total_income, needs, wants, savings)

      binding.pry
      expect(advice).to 
    end

    xit "returns error when there is an invalid input" do
      total_income = nil

      advice = FastapiService.generate_advice(total_income, needs, wants, savings)

      expect(advice).to raise_error(StandardError, "Something went wrong")
    end
  end
end