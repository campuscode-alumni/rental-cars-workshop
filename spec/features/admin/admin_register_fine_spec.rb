require 'rails_helper'

feature 'Admin register fine' do
  scenario 'successfully' do
    create(:subsidiary)
    user = create(:user)
    car_model = create(:car_model, name: 'Palio')
    car = create(:car, car_model: car_model, license_plate: 'ABC-1234',
                       subsidiary: user.subsidiary)
    create(:personal_customer, name: 'Renan')

    login_as user, scope: :user
    visit root_path
    fill_in 'search-field', with: 'ABC-1234'
    click_on 'Buscar'
    click_on 'Registrar Multa'
    fill_in 'Data de emissão', with: '12/03/2019'
    fill_in 'Quantidade de pontos', with: 12
    fill_in 'Valor', with: 100.00
    fill_in 'Endereço da ocorrência', with: 'Rua Banana, 02'
    click_on 'Cadastrar Multa'

    expect(page).to have_content(car_model.name)
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content('Multa registrada com sucesso')
    expect(page).to have_content('Multa emitida em: 12/03/2019')
    expect(page).to have_content('Quantidade de pontos: 12')
    expect(page).to have_content('Valor: R$ 100,00')
    expect(page).to have_content('Endereço da ocorrência: Rua Banana, 02')
    credit = Credit.last
    expect(credit.amount).to eq 100
    expect(credit.subsidiary).to eq user.subsidiary
    expect(credit.transactable).to eq Fine.last
  end

  scenario 'must be valid' do
    create(:subsidiary)
    user = create(:user)
    car_model = create(:car_model, name: 'Palio')
    create(:car, car_model: car_model, license_plate: 'ABC-1234',
                 subsidiary: user.subsidiary)
    create(:personal_customer, name: 'Renan')

    login_as user, scope: :user
    visit root_path
    fill_in 'search-field', with: 'ABC-1234'
    click_on 'Buscar'
    click_on 'Registrar Multa'
    fill_in 'Data de emissão', with: ''
    fill_in 'Quantidade de pontos', with: ''
    fill_in 'Valor', with: ''
    fill_in 'Endereço da ocorrência', with: ''
    click_on 'Cadastrar Multa'

    expect(page).to have_content('Não foi posível cadastrar multa')
  end
end
