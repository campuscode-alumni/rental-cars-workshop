require 'rails_helper'

RSpec.describe CompanyCustomer, type: :model do
  describe '#personal_customer?' do
    it 'returns false' do
      personal_customer = build(:company_customer)
      expect(personal_customer.personal_customer?).to be false
    end
  end

  describe '#company_customer?' do
    it 'returns true' do
      personal_customer = build(:company_customer)
      expect(personal_customer.company_customer?).to be true
    end
  end
end
