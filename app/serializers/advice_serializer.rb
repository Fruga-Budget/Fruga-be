class AdviceSerializer
  include JSONAPI::Serializer

  set_id :id

  attributes :total_income, :needs_total, :wants_total, :savings_total, :expenses, :advice

  attribute :expenses do |object|
    {
      needs: object.needs.map { |need| { name: need["name"], amount: need["cost"], description: need["description"], isNegotiable: need["isNegotiable"] } },
      wants: object.wants.map { |want| { name: want["name"], amount: want["cost"], description: want["description"] } },
      savings: object.savings.map { |saving| { name: saving["name"], amount: saving["cost"], description: saving["description"] } }
    }
  end

  attribute :advice do |object|
    object.recommendation.split('. ').map(&:strip)
  end
end
