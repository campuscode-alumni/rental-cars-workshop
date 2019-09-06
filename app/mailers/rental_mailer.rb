class RentalMailer < ApplicationMailer
  def send_rental_receipt(rental_id)
    @rental = Rental.find(rental_id)
    @customer = @rental.customer
    @car = @rental.car

    mail(to: @customer.email,
         subject: "Recibo de aluguel - #{@car.license_plate}")
  end

  def send_return_receipt(rental_id)
    @rental = Rental.find(rental_id)
    @customer = @rental.customer
    @car = @rental.car
    mail(to: @customer.email, subject: 'Seu recibo de devolução')
  end
end
