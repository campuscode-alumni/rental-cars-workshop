require 'rails_helper'

feature 'User register rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    car = create(:car, subsidiary: user.subsidiary)
    customer = create(:customer, cpf: '123456789')
    create(:rental, car: car, user: user, customer: customer)

    login_as user
    visit root_path
    click_on 'Registrar Locação'

    select car.car_identification.to_s, from: 'Carro'
    select customer.cpf.to_s, from: 'Cliente'
    click_on 'Enviar'

    expect(page).to have_content('Cliente possui locação em aberto')
  end
end
