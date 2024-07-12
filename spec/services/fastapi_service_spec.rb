require "rails_helper"

RSpec.describe "Python Service", type: :service, vcr: true do
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

      binding.pry
      expect(advice)
    end

    it "returns error when there is an invalid input" do
      total_income = nil
      needs = 2000
      wants = 800
      savings = 600

      advice = FastapiService.generate_advice(total_income, needs, wants, savings)

      expect(advice).to raise_error(StandardError, "Something went wrong")
    end
  end
end