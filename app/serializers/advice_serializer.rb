class AdviceSerializer
  include JSONAPI::Serializer
  
  attributes :total_income, :expenses, :advice

  attribute :expenses do |object|
    {
      needs: object.needs.map { |need| { name: need["name"], amount: need["cost"], description: need["description"], isNegotiable: need["isNegotiable"] } },
      wants: object.wants.map { |want| { name: want["name"], amount: want["cost"], description: want["description"] } },
      savings: object.savings.map { |saving| { name: saving["name"], amount: saving["cost"], description: saving["description"] } }
    }
  end

  #format each sentence of the response into indices of an array and remove white space
  attribute :advice do |object|
    object.advice.split('. ').map(&:strip)
  end
end