require 'rails_helper'

feature 'successfully' do
  scenario 'user view ten cars in maintenance' do
    user = create(:user)
    car_model = create(:car_model, name: 'Banana Model')
    cars = create_list(:car, 10, :on_maintenance)
    cars << create(:car, :on_maintenance, car_model: car_model)

    login_as user
    visit root_path

    within 'div#maintenance' do
      cars.first(10).each do |car|
        expect(page).to have_content(car.car_model.name)
        expect(page).to have_content(car.license_plate)
      end
      expect(cars.count).to eq 11
      expect(page).not_to have_content(cars.last.car_model.name)
      expect(page).not_to have_content(cars.last.license_plate)
    end
  end

  scenario 'user all cars on maintenance' do
    user = create(:user)
    cars = create_list(:car, 11, :on_maintenance)

    login_as user
    visit root_path

    click_on 'Ver todos os carros em manutenção'
    expect(current_path).to eq maintenances_path
    cars.each do |car|
      expect(page).to have_content(car.car_model.name)
      expect(page).to have_content(car.license_plate)
    end
  end
end
