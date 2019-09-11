require 'rails_helper'

describe FineIssuer do
  describe '#call' do
    it 'should emmit a fine and credit' do
      car = create(:car)
      fine_attributes = build(:fine).attributes

      result = described_class.new(car, fine_attributes).call

      expect(result).to be_persisted
      expect(Credit.count).to eq 1
    end

    it 'should not emmit credit if not valid' do
      car = create(:car)

      result = described_class.new(car, {}).call

      expect(result).not_to be_persisted
      expect(Credit.count).to eq 0
    end
  end
end
