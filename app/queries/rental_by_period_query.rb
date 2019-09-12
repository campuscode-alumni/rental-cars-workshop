class RentalByPeriodQuery
  def initialize(range)
    @range = range
  end

  def call
    Subsidiary.where(cars: { rentals: { started_at: range } })
      .left_joins(cars: :rentals)
      .group(:id)
      .count
  end

  private

  attr_reader :range
end
