require 'rails_helper'

feature 'User schedule rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    car_model = create(:car_model, manufacture: manufacture)
    car = create(:car, car_model: car_model, subsidiary: user.subsidiary)
    customer = create(:personal_customer)

    login_as user
    visit root_path
    click_on 'Agendar Locação'

    select car.car_identification.to_s, from: 'Carro'
    select customer.description, from: 'Cliente'
    fill_in 'Retirada Prevista', with: '20/10/2019'
    fill_in 'Devolução Prevista', with: '25/10/2019'
    click_on 'Enviar'

    expect(page).to have_content(car.car_identification)
    expect(page).to have_content(customer.description)
    expect(page).to have_content(user.email)
    expect(page).to have_content('Status: Agendada')
    expect(page).to have_content('Retirada Prevista: 20/10/2019')
    expect(page).to have_content('Devolução Prevista: 25/10/2019')
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
    create(:personal_customer)

    login_as user_paulista
    visit root_path
    click_on 'Agendar Locação'

    expect(page).to_not have_content(car_sao_miguel.car_identification)
    expect(page).to have_content(car_paulista.car_identification)
  end

  scenario 'customer cannot rent twice' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    car = create(:car, subsidiary: subsidiary)
    customer = create(:personal_customer, name: 'Henrique')
    create(:rental, car: car, user: user, customer: customer, status: :active)

    login_as user
    visit root_path
    click_on 'Agendar Locação'

    select car.car_identification.to_s, from: 'Carro'
    select customer.description, from: 'Cliente'
    fill_in 'Retirada Prevista', with: '20/10/2019'
    fill_in 'Devolução Prevista', with: '25/10/2019'
    click_on 'Enviar'

    expect(page).to have_content('Cliente possui locação em aberto')
  end

  scenario 'company can rent twice' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    car = create(:car, subsidiary: subsidiary)
    customer = create(:company_customer, name: 'Acme INC')
    create(:rental, car: car, user: user, customer: customer, status: :active)

    login_as user
    visit root_path
    click_on 'Agendar Locação'

    select car.car_identification.to_s, from: 'Carro'
    select customer.description, from: 'Cliente'
    fill_in 'Retirada Prevista', with: '20/10/2019'
    fill_in 'Devolução Prevista', with: '25/10/2019'
    click_on 'Enviar'

    expect(page).to have_content('Um email de confirmação foi enviado para o cliente')
    expect(page).to have_content(car.car_identification)
    expect(page).to have_content(customer.description)
    expect(page).to have_content(user.email)
  end
end
