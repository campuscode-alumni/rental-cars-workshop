require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    fiat = create(:manufacture, name: 'Fiat')
    create(:car_model, name: 'Sport', manufacture: fiat)

    login_as user, scope: :user
    visit root_path

    click_on 'Registrar novo carro'
    select 'Sport', from: 'Modelo'
    fill_in 'Quilometragem', with: '200'
    fill_in 'Cor', with: 'Verde Musgo'
    fill_in 'Placa', with: 'HPL6666'
    click_on 'Criar carro'

    expect(page).to have_content('Sport')
    expect(page).to have_content('Quilometragem')
    expect(page).to have_content('200')
    expect(page).to have_content('Cor')
    expect(page).to have_content('Verde Musgo')
    expect(page).to have_content('HPL6666')
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar novo carro'
    click_on 'Criar carro'

    expect(page).to have_content('Modelo não pode ficar em branco')
    expect(page).to have_content('Quilometragem não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to have_content('Placa não pode ficar em branco')
  end
end
