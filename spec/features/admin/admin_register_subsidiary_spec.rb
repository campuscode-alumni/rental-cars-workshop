require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar nova filial'
    fill_in 'Nome', with: 'Rent a car'
    fill_in 'Logradouro', with: 'Vila do Chaves'
    fill_in 'Número', with: '71'
    fill_in 'Complemento', with: 'Dentro do barril'
    fill_in 'Bairro', with: 'México'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Criar filial'

    expect(page).to have_content('Rent a car')
    expect(page).to have_content('Endereço')
    expect(page).to have_content('Vila do Chaves, nº 71')
    expect(page).to have_content('Dentro do barril')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar nova filial'
    click_on 'Criar filial'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Logradouro não pode ficar em branco')
    expect(page).to have_content('Número não pode ficar em branco')
    expect(page).to have_content('Bairro não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
  end
end
