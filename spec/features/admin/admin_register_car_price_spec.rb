require 'rails_helper'

feature 'Admin register car price' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    fiat = create(:manufacture, name: 'Fiat')
    CarModel.create!(name: 'Opala', year: '1989/1990',
                     manufacture: fiat,
                     car_options: 'Preto')

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar novo preço'
    select 'Opala', from: 'Selecione o modelo'
    fill_in 'Preço', with: '299'
    click_on 'Cadastrar preço'

    expect(page).to have_content('Preço cadastrado com sucesso')
    expect(page).to have_content('Opala')
    expect(page).to have_content('299')
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    fiat = create(:manufacture, name: 'Fiat')
    CarModel.create!(name: 'Opala', year: '1989/1990',
                     manufacture: fiat,
                     car_options: 'Preto')

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar novo preço'
    select '', from: 'Selecione o modelo'
    fill_in 'Preço', with: ''
    click_on 'Cadastrar preço'

    expect(page).to have_content('Preço não pode ficar em branco')
  end
end
