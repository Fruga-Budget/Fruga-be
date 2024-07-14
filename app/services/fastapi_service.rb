class FastapiService

def self.generate_advice(total_income, needs, wants, savings)
  url = "/v1/generate_advice" #this will probably change
  params = {
    total_income: total_income,
    needs: needs,
    wants: wants,
    savings: savings
  }

  response = call_api(url, params) #instance method needs 
  parse_response(response)
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
    Faraday.new(url: "http://127.0.0.1:8000") #this may change based off fruga-py-service main.py file
  end

  def self.parse_response(response)
    if response[:error]
      raise StandardError.new(response[:error])
    else
      response[:advice]
    end
  end
end