require "rails_helper"

RSpec.describe "Python Service", type: :service, vcr: do
  it "exists" do
    service = FastapiService.new

    expect(service).to be_a FastapiService
  end

  describe "#generate_advice" do
    it "returns json response with given input" do
      total_income = 5000
      needs = [{rent: 1800, car: 500, utilities: 600, food: 500}]
      wants = [{restaurants: 200, shopping: 300}]
      savings = [{"401k" => 200, "emergency fund" => 100}]

      advice = FastapiService.generate_advice(total_income, needs, wants, savings)

      binding.pry
      expect(advice)
    end

    it "returns error when there is an invalid input" do
      total_income = nil
      needs = [{rent: 1800, car: 500, utilities: 600, food: 500}]
      wants = [{restaurants: 200, shopping: 300}]
      savings = [{"401k" => 200, "emergency fund" => 100}]

      advice = FastapiService.generate_advice(total_income, needs, wants, savings)

      expect(advice).to raise_error(StandardError, "Something went wrong")
    end
  end
end