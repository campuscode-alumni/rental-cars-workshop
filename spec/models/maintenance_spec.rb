require 'rails_helper'

RSpec.describe Maintenance, type: :model do
  describe '#car_return' do
    let(:car) { create(:car, status: :on_maintenance) }
    let(:provider) do
      Provider.create(name: 'Solucoes.ltda', cnpj: '1234567/777')
    end

    it 'should create a debit' do
      maintenance = create(:maintenance, car: car, provider: provider)
      maintenance.car_return(service_cost: 1000, invoice: 'GHASHASDB123J81NN')

      expect(maintenance).to be_valid
      expect(Debit.last.amount).to eq maintenance.service_cost
    end

    it 'should set the car status toavailable' do
      maintenance = create(:maintenance, car: car, provider: provider)
      maintenance.car_return(service_cost: 1000, invoice: 'GHASHASDB123J81NN')

      expect(car.status).to eq 'available'
    end
  end
end
