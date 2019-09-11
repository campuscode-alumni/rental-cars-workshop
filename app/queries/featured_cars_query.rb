class FeaturedCarsQuery
  def initialize(cars = Car.all)
    @cars = cars
  end

  def first(number = 10)
    @cars.left_joins(:rentals)
         .group(:id)
         .order('COUNT(rentals.id) DESC')
         .limit(number)
  end
end
