require 'rails_helper'

describe MaintenancePolicy do
  describe 'authorized?' do
    it 'should be true if admin' do
      user = build(:user, :admin)
      car = build(:car)

      result = MaintenancePolicy.new(car, user).authorized?
      expect(result).to eq true
    end

    it 'should be false if employee' do
      user = build(:user, role: :employee)
      car = build(:car)

      result = MaintenancePolicy.new(car, user).authorized?
      expect(result).to eq false
    end

    it 'should be true if manager and same subsidiary' do
      sub = create(:subsidiary)
      user = build(:user, role: :manager, subsidiary: sub)
      car = build(:car, subsidiary: sub)

      result = MaintenancePolicy.new(car, user).authorized?
      expect(result).to be true
    end

    it 'should be false if manager and other subsidiary' do
      sub = create(:subsidiary, name: 'Matriz')
      other_sub = create(:subsidiary, name: 'Paulista')

      user = build(:user, role: :manager, subsidiary: sub)
      car = build(:car, subsidiary: other_sub)

      result = MaintenancePolicy.new(car, user).authorized?
      expect(result).to be false
    end

    it 'should be false if guest' do
      guest = NilUser.new
      car = build(:car)

      result = MaintenancePolicy.new(car, guest).authorized?
      expect(result).to be false
    end
  end
end
