require 'rails_helper'

RSpec.describe PersonalCustomer, type: :model do
  describe '#personal_customer?' do
    it 'returns true' do
      personal_customer = build(:personal_customer)
      expect(personal_customer.personal_customer?).to be true
    end
  end

  describe '#company_customer?' do
    it 'returns false' do
      personal_customer = build(:personal_customer)
      expect(personal_customer.company_customer?).to be false
    end
  end

end
