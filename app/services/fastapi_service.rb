class FastapiService

def generate_advice(total_income, needs, wants, savings)
  url = "generate_advice"
  params = {
    total_income: total_income,
    needs: needs,
    wants: wants,
    savings: savings
  }

  response = self.class.call_api(url, params)
  self.class.parse_response(response)
end

  private

  def self.call_api(url, params = {})
    response = connection.post(url) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end
    JSON.parse(response.body, symbolize_names: true)
  rescue Faraday::Error => e
    { error: e.message }
  end

  def self.connection
    Faraday.new('https://localhost:8000/') #this may change based off fruga-py-service main.py file
  end

  def self.parse_response(response)
    if response[:error]
      raise StandardError.new(response[:error])
    else
      response[:advice]
    end
  end
end