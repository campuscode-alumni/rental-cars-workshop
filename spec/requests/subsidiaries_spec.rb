require 'rails_helper'

RSpec.describe 'Subsidiaries API', type: :request do
  context 'get /subsidiaries' do
    it 'should list all subsidiaries' do
      create_list(:subsidiary, 2, name: 'Joao')
      create_list(:subsidiary, 2, name: 'Mateus')

      get '/api/v1/subsidiaries'

      parsed_body = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(parsed_body.size).to eq 4
      expect(response.body.scan(/(?=Joao)/).count).to eq 2
      expect(response.body.scan(/(?=Mateus)/).count).to eq 2
    end
  end
end
