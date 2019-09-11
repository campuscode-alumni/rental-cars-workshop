class FineIssuer

  def initialize(car, parameters)
    @car = car
    @parameters = parameters
  end

  def call
    fine.save
    create_credit
    fine
  end

  private

  def create_credit
    return unless fine.persisted?

    fine.create_credit(amount: fine.fine_value,
                       subsidiary: car.subsidiary)
  end

  def fine
    @fine ||= car.fines.new(parameters)
  end

  attr_reader :car, :parameters
end
