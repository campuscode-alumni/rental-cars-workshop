require 'rails_helper'

feature 'Admin edit customer' do
  scenario 'successfully' do
    user = create(:user)
    create(:customer, name: 'Juliana', cpf: '123456789')

    login_as user, scope: :user
    visit root_path
    click_on 'Ver Clientes'
    click_on 'Juliana'
    click_on 'Editar cliente'
    fill_in 'Nome', with: 'Juliana'
    fill_in 'Email', with: 'ju@exemplo.com'
    fill_in 'CPF', with: '123456789'
    fill_in 'Telefone', with: '234342223'
    click_on 'Cadastrar cliente'

    expect(page).to have_content('Juliana')
    expect(page).to have_content('ju@exemplo.com')
    expect(page).to have_content('123456789')
    expect(page).to have_content('234342223')
    expect(page).to have_content('Cliente editado com sucesso')
    expect(page).to have_link('Voltar')
  end

  scenario 'unsuccessfully' do
    user = create(:user)
    create(:customer, name: 'Juliana', cpf: '123456789')

    login_as user, scope: :user
    visit root_path
    click_on 'Ver Clientes'
    click_on 'Juliana'
    click_on 'Editar cliente'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Cadastrar cliente'

    expect(page).to have_content('Você deve preencher todos os campos')
  end
end
