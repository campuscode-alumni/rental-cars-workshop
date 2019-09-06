require 'rails_helper'

feature 'User return car from maintenance' do
  scenario 'successfully' do
    user = create(:user)
    provider = Provider.create(name: 'Solucoes.ltda', cnpj: '1234567/777')
    fiat = create(:manufacture, name: 'Fiat')
    palio = create(:car_model, name: 'Palio', manufacture: fiat)
    car = create(:car, car_model: palio, license_plate: 'xlg1234',
                       status: :on_maintenance)
    maintenance = create(:maintenance, car: car, provider: provider)

    login_as user, scope: :user
    visit root_path
    click_on 'Carros em Manutenção'
    click_on 'Palio - xlg1234'
    click_on 'Dar baixa em manutenção'
    fill_in 'Nota Fiscal', with: 'NF0137'
    fill_in 'Valor', with: '2500'
    click_on 'Retornar de manutenção'

    expect(current_path).to eq car_return_maintenance_path(maintenance)
    expect(page).to have_content('NF0137')
    expect(page).to have_content('R$ 2.500,00')
    expect(page).to have_content('Carro disponível')
    expect(page).to have_content('Status: Disponível')
    expect(page).not_to have_link('Retornar de manutenção')
  end

  scenario 'only cars on maintenance' do
    user = create(:user)
    provider = create(:provider, name: 'Solucoes.ltda', cnpj: '1234567/777')
    car_palio = create(:car, license_plate: 'XLG1234', status: :on_maintenance)
    car_uno = create(:car, license_plate: 'GLS4567')
    create(:maintenance, car: car_palio, provider: provider)

    # acoes
    login_as user
    visit root_path

    click_on 'Carros em Manutenção'

    # expectativas
    expect(current_path).to eq maintenances_path
    expect(page).to have_content(car_palio.car_identification)
    expect(page).to_not have_content(car_uno.car_identification)
  end

  scenario 'validates invoice and service cost on return' do
    user = create(:user)
    provider = Provider.create(name: 'Solucoes.ltda', cnpj: '1234567/777')
    car = create(:car, license_plate: 'XLG1234', status: :on_maintenance)
    create(:maintenance, car: car, provider: provider)

    login_as user, scope: :user
    visit root_path
    click_on 'Carros em Manutenção'
    click_on car.car_identification
    click_on 'Dar baixa em manutenção'
    fill_in 'Nota Fiscal', with: ''
    fill_in 'Valor', with: ''
    click_on 'Retornar de manutenção'

    expect(page).to have_content 'Nota Fiscal não pode ficar em branco'
    expect(page).to have_content 'Valor não pode ficar em branco'
  end

  scenario 'generates a debit' do
    user = create(:user)
    provider = Provider.create(name: 'Solucoes.ltda', cnpj: '1234567/777')
    fiat = create(:manufacture, name: 'Fiat')
    palio = create(:car_model, name: 'Palio', manufacture: fiat)
    car = create(:car, car_model: palio, license_plate: 'xlg1234',
                       status: :on_maintenance)
    create(:maintenance, car: car, provider: provider)

    login_as user, scope: :user
    visit root_path
    click_on 'Carros em Manutenção'
    click_on 'Palio - xlg1234'
    click_on 'Dar baixa em manutenção'
    fill_in 'Nota Fiscal', with: 'NF0137'
    fill_in 'Valor', with: '2500'
    click_on 'Retornar de manutenção'

    debit = Debit.last
    expect(debit.amount).to eq 2500
    expect(debit.subsidiary).to eq car.subsidiary
  end
end
