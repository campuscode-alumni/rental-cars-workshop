class RentalFinisher
  def initialize(rental, new_km, mailer = RentalMailer)
    @rental = rental
    @new_km = new_km
    @customer = rental.customer
    @car = rental.car
    @mailer = mailer
  end

  def finish()
    return false unless car.update(car_km: new_km, status: :available)
    finish_rental
    notify_customer
    true
  end

  private

  attr_reader :car, :customer, :rental, :new_km, :mailer

  def finish_rental
    rental.update(status: :finished, finished_at: Time.zone.now)
  end

  def notify_customer
    mailer.send_return_receipt(rental.id).deliver_now
  end
end
