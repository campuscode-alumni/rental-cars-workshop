class RentalFinisher
  def initialize(rental, new_km, mailer = RentalMailer, services = [
    CarReturner, RentalFinisherNotifier, InspectionStarter ])
    @rental = rental
    @new_km = new_km
    @customer = rental.customer
    @car = rental.car
    @mailer = mailer
  end

  def finish()
    finish_rental
    services.each { |s| s.new(rental).call }
  end

  private

  attr_reader :car, :customer, :rental, :new_km, :mailer

  def finish_rental
    rental.update(status: :finished, finished_at: Time.zone.now)
  end

  def return_car
     car.update(car_km: new_km, status: :available)
  end


  def notify_customer
    mailer.send_return_receipt(rental.id).deliver_now
  end
end
