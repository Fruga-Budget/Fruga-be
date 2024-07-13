class Api::V1::AdvicesController < ApplicationController

  def create
    total_income = params[:total_income].to_f
    needs = params[:needs]
    wants = params[:wants]
    savings = params[:savings]

    needs_total = needs.sum { |need| need[:cost].to_f }
    wants_total = wants.sum { |want| want[:cost].to_f }

    advice = {
      id: SecureRandom.uuid,
      total_income: total_income,
      needs: needs,
      wants: wants,
      savings: savings,
      needs_total: needs_total,
      wants_total: wants_total,
      recommendation: recommendation
    }

    ready_to_generate = AdviceGenerator.new(total_income, needs, wants, savings)
    recommendation = ready_to_generate.check_to_call_api

    render json: AdviceSerializer.new(advice), status: :ok
  end

  private

  def advice_params
    params.require(:advice).permit(:total_income, needs: [:name, :cost, :isNegotiable], wants: [:name, :cost], savings: [:name, :cost])
  end
end