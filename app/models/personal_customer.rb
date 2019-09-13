class PersonalCustomer < Customer
  #validates :cpf, presence: true, cpf: true, uniqueness: true

  def personal_customer?
    true
  end

  def company_customer?
    false
  end
end
