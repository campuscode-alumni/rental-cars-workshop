require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    create(:manufacture, name: 'Fiat')

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar novo modelo'
    fill_in 'Nome', with: 'Fiat Novo Uno 1.0'
    fill_in 'Ano', with: '2014/2015'
    select 'Fiat', from: 'Marca'
    fill_in 'Características', with: '2 portas,5 pessoas'
    click_on 'Criar modelo'

    expect(page).to have_content('Nome')
    expect(page).to have_content('Fiat Novo Uno 1.0')
    expect(page).to have_content('Ano')
    expect(page).to have_content('2014/2015')
    expect(page).to have_content('Marca')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('Características')
    expect(page).to have_content('2 portas')
    expect(page).to have_content('5 pessoas')
  end

  scenario 'and don\'t fill all fields' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar novo modelo'
    click_on 'Criar modelo'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Características não pode ficar em branco')
  end
end
