sub = Subsidiary.create(name: 'Unidade Paulista')
Subsidiary.create(name: 'Unidade Santo Amaro')
Subsidiary.create(name: 'Unidade São Bernardo')

user = User.create(email: 'user@rental.com', password: '123456', 
                   subsidiary: sub, role: :employee)
manager = User.create(email: 'manager@rental.com', password: '123456', 
                   subsidiary: sub, role: :manager)

manufacture = Manufacture.create(name: 'Chevrolet')
other_manufacture = Manufacture.create(name: 'Honda')

car_model = CarModel.create(name: 'Onyx Joy', year: 2019, car_options: 'Ar Cond',
                            manufacture: manufacture)

CarModel.create(name: 'Prisma LT', year: 2019, car_options: 'Ar Condicionado, central multimídia',
               manufacture: manufacture)

other_car_model = CarModel.create(name: 'City LX', year: 2019, car_options: 'Som e Ar condicionado',
                           manufacture: other_manufacture)


Car.create(car_model: car_model, subsidiary: sub, car_km: 1450, color: 'Preto',
          license_plate: 'XYZ-0101')

Car.create(car_model: car_model, subsidiary: sub, car_km: 2450, color: 'Branco',
          license_plate: 'TYP-9090')

Car.create(car_model: other_car_model, subsidiary: sub, car_km: 9450, color: 'Prata',
          license_plate: 'HCP-3160')
