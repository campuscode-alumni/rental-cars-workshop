sub = Subsidiary.create(name: 'Unidade Paulista')
Subsidiary.create(name: 'Unidade Santo Amaro')
Subsidiary.create(name: 'Unidade São Bernardo')

user = User.create(email: 'admin@rental.com', password: '123456', 
                   subsidiary: sub)
manufacture = Manufacture.create(name: 'Chevrolet')

car_model = CarModel.create(name: 'Onyx Joy', year: 2019, car_options: 'Ar Cond',
                            manufacture: manufacture)

CarModel.create(name: 'Prisma LT', year: 2019, car_options: 'Ar Condicionado, central multimídia',
               manufacture: manufacture)
