class FastapiService

def self.generate_advice(total_income, needs, wants, savings)
  url = "/v1/generate_advice"
  params = {
    total_income: total_income,
    needs: format_needs(needs),
    wants: format_wants(wants),
    savings: format_savings(savings)
  }

  # puts "Sending params to external API: #{params.to_json}"
  response = call_api(url, params) 
  parse_response(response)
end

  private

  def self.call_api(url, params = {})
    # puts "Sending params to external API: #{params.to_json}"
    response = connection.post(url) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end
    # puts "Received response from external API: #{response.body}"
    JSON.parse(response.body, symbolize_names: true)
  rescue Faraday::Error => e
    { error: e.message }
  end

  def self.connection
    Faraday.new(url: ENV['API_BASE_URL'])
  end

  def self.parse_response(response)
    if response[:error]
      raise StandardError.new(response[:error])
    else
      response[:advice]
    end
  end

   def self.format_needs(needs)
    needs.map do |need|
      {
        name: need['name'],
        cost: need['cost'],
        description: need['description'],
        isNegotiable: need['isNegotiable']
      }
    end
  end

  def self.format_wants(wants)
    wants.map do |want|
      {
        name: want['name'],
        cost: want['cost'],
        description: want['description']
      }
    end
  end

  def self.format_savings(savings)
    savings.map do |saving|
      {
        name: saving['name'],
        cost: saving['cost'],
        description: saving['description']
      }
    end
  end
end