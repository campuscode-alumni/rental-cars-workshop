require 'rails_helper'

RSpec.describe 'Cars API', type: :request do
  context 'get /cars/1' do
    it 'should return a single car' do
      subsidiary = create(:subsidiary)
      manufacture = create(:manufacture, name: 'Honda')
      car_model = create(:car_model, manufacture: manufacture, name: 'City')
      car = create(:car, license_plate: 'EQH-8038', car_model: car_model,
                         subsidiary: subsidiary)

      get "/api/v1/cars/#{car.id}"

      result = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(result['license_plate']).to include 'EQH-8038'
    end

    it 'should return 404' do
      get '/api/v1/cars/0'

      expect(response).to have_http_status :not_found
    end
  end
end
