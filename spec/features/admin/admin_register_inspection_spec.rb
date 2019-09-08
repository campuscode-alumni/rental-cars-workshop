require 'rails_helper'

feature 'Admin register inspection' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    palio = create(:car_model, name: 'Palio')
    create(:car, car_model: palio, license_plate: 'XLG-1234',
                 subsidiary: user.subsidiary)

    login_as user
    visit root_path
    click_on 'Palio - XLG-1234'
    click_on 'Enviar para vistoria'
    select '1/4', from: 'Nível de combustível'
    select 'Limpo', from: 'Limpeza'
    fill_in 'Avarias', with: 'Veio pneu furado'
    click_on 'Vistoriado'

    expect(page).to have_link('Enviar para vistoria')
    expect(page).to have_content('Status: Disponível')
  end
end
