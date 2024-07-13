require "rails_helper"

RSpec.describe "Python Service", type: :service, vcr: true do
  it "exists" do
    service = FastapiService.new

    expect(service).to be_a FastapiService
  end

  describe "#generate_advice" do
    it "returns json response with given input" do
      total_income = 5000
      needs = [{"name" => "rent", "cost" => 1800}, 
                {"name" => "car", "cost" => 500}, 
                {"name" => "utilities", "cost" => 600}, 
                {"name" => "food", "cost" => 500}]
      wants = [{"name" => "restaurants", "cost" => 200},
                {"name" => "shopping", "cost" => 300}]
      savings = [{"name" => "401k","cost" => 200},
                  {"name" => "emergency fund", "cost" => 100}]

      advice = FastapiService.generate_advice(total_income, needs, wants, savings)

      binding.pry
      expect(advice)
    end

    xit "returns error when there is an invalid input" do
      total_income = nil
      needs = [{"name" => "rent", "cost" => 1800}, 
                {"name" => "car", "cost" => 500}, 
                {"name" => "utilities", "cost" => 600}, 
                {"name" => "food", "cost" => 500}]
      wants = [{"name" => "restaurants", "cost" => 200},
                {"name" => "shopping", "cost" => 300}]
      savings = [{"name" => "401k","cost" => 200},
                  {"name" => "emergency fund", "cost" => 100}]

      advice = FastapiService.generate_advice(total_income, needs, wants, savings)

      expect(advice).to raise_error(StandardError, "Something went wrong")
    end
  end
end