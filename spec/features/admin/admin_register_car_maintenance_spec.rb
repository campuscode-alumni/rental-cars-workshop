require 'rails_helper'

feature 'Admin send car to maintenance ' do
  scenario 'successfully' do
    user = create(:user)
    provider = create(:provider, name: 'Solucoes.ltda', cnpj: '1234567/777')
    fiat = create(:manufacture, name: 'Fiat')
    palio = create(:car_model, name: 'Palio', manufacture: fiat)
    car = create(:car, car_model: palio, license_plate: 'XLG-1234', car_km: 199)

    login_as user, scope: :user
    visit root_path

    click_on 'Palio - XLG-1234'
    click_on 'Enviar para manutenção'
    select 'Solucoes.ltda', from: 'Fornecedor parceiro'
    click_on 'Enviar para manutenção'

    m = Maintenance.last
    expect(m.provider).to eq provider
    expect(m.car).to eq car
    expect(page).to have_content('Carro enviado para manutenção')
    expect(current_path).to eq car_path(car)
    expect(page).not_to have_link('Enviar para manutenção')
    expect(page).to have_content('Status: Em manutenção')
  end

  scenario 'cannot send twice' do
    user = create(:user)
    provider = create(:provider, name: 'Solucoes.ltda', cnpj: '1234567/777')
    fiat = create(:manufacture, name: 'Fiat')
    palio = create(:car_model, name: 'Palio', manufacture: fiat)
    car = create(:car, car_model: palio, license_plate: 'XLG-1234',
                       status: :on_maintenance)
    create(:maintenance, car: car, provider: provider)

    login_as user, scope: :user
    visit root_path

    click_on 'Palio - XLG-1234'
    expect(page).not_to have_link('Enviar para manutenção')
    expect(page).to have_content('Status: Em manutenção')
  end
end
