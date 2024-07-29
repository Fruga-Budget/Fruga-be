class Api::V1::AdvicesController < ApplicationController
  def index
    user = User.find_by(id: params[:user_id])
    if !user.nil?
      if user.advices.empty?
        render json: { data: [] }, status: :ok
      else
        render json: AdviceSerializer.new(user.advices).to_json, status: :ok
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
  
  def create
    total_income = advice_params[:total_income].to_f
    needs = advice_params[:needs]
    wants = advice_params[:wants]
    savings = advice_params[:savings]

    ready_to_generate = AdviceGenerator.new(total_income, needs, wants, savings)
    recommendation = ready_to_generate.check_to_call_api

    needs_total = needs.sum { |need| need[:cost].to_f }
    wants_total = wants.sum { |want| want[:cost].to_f }
    savings_total = savings.sum { |saving| saving[:cost].to_f }

    advice = Advice.new(
      user_id: user_params[:user_id],
      total_income: total_income,
      needs: needs,
      wants: wants,
      savings: savings,
      needs_total: needs_total,
      wants_total: wants_total,
      savings_total: savings_total,
      recommendation: recommendation
    )
    
    if advice.save
      render json: AdviceSerializer.new(advice).to_json, status: :ok
    else
      render json: { error: advice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def advice_params
    params.require(:advice).permit(
      :total_income, 
      needs: [:name, :cost, :description, :isNegotiable], 
      wants: [:name, :cost, :description], 
      savings: [:name, :cost, :description]
    )
  end

  def user_params
    params.permit( 
      :user_id
    )
  end
end
