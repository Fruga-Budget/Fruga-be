class AdviceGenerator
  attr_reader :total_income, :needs, :wants, :savings

  def initialize(total_income, needs, wants, savings)
    @total_income = total_income
    @needs = needs
    @wants = wants
    @savings = savings
  end

  def check_to_call_api
    if valid_allocation?
      "Congratulations, you're on the right track for the 50/30/20 rule of budgeting!"
    else
      FastapiService.generate_advice(total_income, needs, wants, savings)
    end
  end

  private

  def valid_allocation?
    needs_total = calculate_total(needs)
    wants_total = calculate_total(wants)
    savings_total = calculate_total(savings)

    needs_percentage = (needs_total / total_income) * 100
    wants_percentage = (wants_total / total_income) * 100
    savings_percentage = (savings_total / total_income) * 100

    needs_percentage <= 50 && wants_percentage <= 30 && savings_percentage >= 20
  end

  def calculate_total(items)
    return 0 if items.nil? || items.empty?

    items.compact.sum do |item|
      cost = item['cost']
      cost.to_f
    end
  end
end
