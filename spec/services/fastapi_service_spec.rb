require "rails_helper"

RSpec.describe "Python Service" do
  it "exists" do
    service = FastapiService.new

    expect(service).to be_a FastapiService
  end

  describe "#generate_advice" do
    it "returns json response with given input" do
      total_income = 5000
      needs = 2000
      wants = 800
      savings = 600

      advice = FastapiService.generate_advice(total_income, needs, wants, savings)

      
    end
  end
end