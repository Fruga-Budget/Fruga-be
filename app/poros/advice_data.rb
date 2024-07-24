class AdviceData
  attr_reader :id, :total_income, :needs, :wants, :savings, :needs_total, :wants_total, :savings_total, :recommendation

  def initialize(id:, total_income:, needs:, wants:, savings:, needs_total:, wants_total:, savings_total:, recommendation:)
    @id = id
    @total_income = total_income
    @needs = needs
    @wants = wants
    @savings = savings
    @needs_total = needs_total
    @wants_total = wants_total
    @savings_total = savings_total
    @recommendation = recommendation
  end
end
