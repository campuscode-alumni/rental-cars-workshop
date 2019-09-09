require 'rails_helper'

feature 'Admin sends rental recipt through email' do
  scenario 'successfully' do
    sent_mail = class_spy(RentalMailer)
    stub_const('RentalMailer', sent_mail)
    mailer = double('RentalMailer')

    user = create(:user)
    car = create(:car, subsidiary: user.subsidiary)
    customer = create(:personal_customer, name: 'João')
    allow(RentalMailer).to receive(:send_rental_receipt).and_return(mailer)
    allow(mailer).to receive(:deliver_now)

    login_as user
    visit root_path
    click_on 'Agendar Locação'
    select car.car_identification.to_s, from: 'Carro'
    select customer.description, from: 'Cliente'
    fill_in 'Retirada Prevista', with: '20/10/2019'
    fill_in 'Devolução Prevista', with: '25/10/2019'
    click_on 'Enviar'

    expect(page).to have_content('Um email de confirmação foi enviado para o '\
    'cliente')
    expect(RentalMailer).to have_received(:send_rental_receipt)
      .with(Rental.last.id)
  end
end
