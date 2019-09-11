class RentalDateQuery
  def initialize(date_range)
    @date_range = date_range
  end

  def rentals_by_subsidiary
    Subsidiary
      .where(cars: { rentals: { created_at: @date_range } })
      .left_joins(cars: :rentals)
      .group(:id)
      .count
  end
end
