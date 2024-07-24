require 'rails_helper'

RSpec.describe 'User Authentication API', type: :request do
  before do
    @user = User.create!(
      user_name: 'Odell',
      password: 'treats4lyf',
      password_confirmation: 'treats4lyf'
    )
  end

  describe 'POST /api/v1/sessions' do
    let(:valid_credentials) do
      {
        user_name: 'Odell',
        password: 'treats4lyf'
    }.to_json
    end

    let(:invalid_credentials) do
      {
        user_name: 'Odell',
        password: 'wrongpassword'
    }.to_json
    end

    context 'when the request is valid' do
      before { post '/api/v1/sessions', params: valid_credentials, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' } }

      it 'authenticates the user' do
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to eq(@user.id.to_s)
        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to eq('user')
        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to have_key(:user_name)
        expect(json[:data][:attributes][:user_name]).to eq(@user.user_name)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/sessions', params: invalid_credentials, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' } }

      it 'returns an unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:error]).to eq('Invalid user name or password')
      end
    end
  end
end