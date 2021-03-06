require 'rails_helper'

feature 'User return car rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    car_model = create(:car_model, name: 'Palio', manufacture: manufacture)
    car = create(:car, car_model: car_model, license_plate: 'XLG-1234',
                       subsidiary: subsidiary, car_km: '100')
    customer = create(:personal_customer, email: 'lucas@gmail.com')
    rental = create(:rental, car: car, customer: customer, user: user)
    expect(RentalMailer).to receive(:send_return_receipt).with(rental.id)
                                                         .and_call_original

    login_as user
    visit root_path
    click_on "#{rental.id} - XLG-1234"
    click_on 'Confirmar Devolução'

    fill_in 'Quilometragem', with: '199'
    click_on 'Devolver carro'

    expect(page).to have_content('Carro devolvido com sucesso')
    expect(page).to have_content('Status: Disponível ')
    expect(page).to have_content('Quilometragem: 199')
  end

  scenario 'ensure superior km actually' do
    user = create(:user)
    car_model = create(:car_model, name: 'Palio')
    car = create(:car, car_model: car_model, license_plate: 'XLG-1234',
                       subsidiary: user.subsidiary, car_km: 230)
    customer = create(:personal_customer)
    rental = create(:rental, car: car, user: user, customer: customer)

    login_as user
    visit root_path
    click_on "#{rental.id} - XLG-1234"
    click_on 'Confirmar Devolução'

    fill_in 'Quilometragem', with: '199'
    click_on 'Devolver carro'

    expect(page).to have_content('Quilometragem não pode ser menor que a atual')
  end
end
