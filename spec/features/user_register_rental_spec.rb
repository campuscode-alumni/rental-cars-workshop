require 'rails_helper'

feature 'User register rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    car_model = create(:car_model, manufacture: manufacture)
    car = create(:car, car_model: car_model, subsidiary: user.subsidiary)
    customer = create(:customer)

    login_as user
    visit root_path
    click_on 'Registrar Locação'

    select car.car_identification.to_s, from: 'Carro'
    select customer.cpf_name.to_s, from: 'Cliente'
    click_on 'Enviar'

    expect(page).to have_content(car.car_identification)
    expect(page).to have_content(customer.cpf_name.to_s)
    expect(page).to have_content(user.email)
  end

  scenario 'only from current subsidiary' do
    sub_paulista = create(:subsidiary, name: 'Paulista')
    sub_sao_miguel = create(:subsidiary, name: 'São Miguel')
    user_paulista = create(:user, subsidiary: sub_paulista)
    create(:user, subsidiary: sub_sao_miguel)
    manufacture = create(:manufacture)
    palio = create(:car_model, name: 'Palio', manufacture: manufacture)
    onix = create(:car_model, name: 'Ônix', manufacture: manufacture)
    car_paulista = create(:car, car_model: palio, license_plate: 'ABC-1234',
                                color: 'Azul', subsidiary: sub_paulista)
    car_sao_miguel = create(:car, car_model: onix, license_plate: 'CXZ-0987',
                                  color: 'Verde', subsidiary: sub_sao_miguel)
    create(:customer)

    login_as user_paulista
    visit root_path
    click_on 'Registrar Locação'

    expect(page).to_not have_content(car_sao_miguel.car_identification)
    expect(page).to have_content(car_paulista.car_identification)
  end

  scenario 'customer cannot rent twice' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    car = create(:car, subsidiary: user.subsidiary)
    customer = create(:customer, cpf: '123456789')
    create(:rental, car: car, user: user, customer: customer)

    login_as user
    visit root_path
    click_on 'Registrar Locação'

    select car.car_identification.to_s, from: 'Carro'
    select customer.cpf, from: 'Cliente'
    click_on 'Enviar'

    expect(page).to have_content('Cliente possui locação em aberto')
  end
end
