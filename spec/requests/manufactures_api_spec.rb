require 'rails_helper'

RSpec.describe 'Manufactures API', type: :request do
  context 'post /manufactures' do
    it 'returns a 201' do
      post '/api/v1/manufactures', params: { name: 'Fiat' }
      parsed_body = JSON.parse(response.body)

      expect(response.status).to eq 201
      expect(parsed_body['name']).to eq 'Fiat'
      expect(Manufacture.last.name).to eq 'Fiat'
    end
    it 'returns a 412 for missing params' do
      post '/api/v1/manufactures', params: {}

      expect(response.status).to eq 412
    end
    it 'return a 409 due to duplicate resource' do
      Manufacture.create(name: 'Palio')
      post '/api/v1/manufactures', params: { name: 'Palio' }

      expect(response.status).to eq 412
      expect(Manufacture.all.count).to eq 1
    end
  end
end
