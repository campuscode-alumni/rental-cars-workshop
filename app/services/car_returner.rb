class CarReturner
  def initialize(rental, km_value, mailer = RentalMailer)
    @rental = rental
    @km = km_value
    @mailer = mailer
  end

  def call
    car.update(car_km: km, status: :available)
    finish_rental
    send_return_receipt
    returned?
  end

  private

  attr_reader :rental, :km, :mailer

  def returned?
    car.errors.empty?
  end

  def car
    @car ||= rental.car
  end


  def finish_rental
    return unless car.valid?

    rental.finish!
  end

  def send_return_receipt
    return unless car.valid?

    mailer.send_return_receipt(rental.id).deliver_now
  end
end
