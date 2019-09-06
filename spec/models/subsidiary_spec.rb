require 'rails_helper'

RSpec.describe Subsidiary, type: :model do
  describe '#current_price' do
    it 'should return the last price' do
      subsidiary = create(:subsidiary)
      create(:user, subsidiary: subsidiary)
      fiat = create(:manufacture, name: 'Fiat')
      car_model = CarModel.create(name: 'Opala', year: '1989/1990',
                                  manufacture: fiat,
                                  car_options: 'Preto')

      car_model.subsidiary_car_models.create(subsidiary: subsidiary, price: 299)
      create(:subsidiary_car_model, subsidiary: subsidiary, price: 120,
                                    car_model: car_model)

      expect(subsidiary.current_price(car_model)).to eq 120
    end

    it 'should return error' do
      subsidiary = create(:subsidiary)
      create(:user, subsidiary: subsidiary)
      fiat = create(:manufacture, name: 'Fiat')
      car_model = CarModel.create(name: 'Opala', year: '1989/1990',
                                  manufacture: fiat,
                                  car_options: 'Preto')

      result = -> { subsidiary.current_price(car_model) }

      expect(result).to raise_error('Esse carro não possui preço')
    end
  end
end
