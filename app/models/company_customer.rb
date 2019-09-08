class CompanyCustomer < Customer
  validates :cnpj, presence: true, cnpj: true, uniqueness: true

  def company_customer?
    true
  end

  def personal_customer?
    false
  end
end
