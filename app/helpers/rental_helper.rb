module RentalHelper
  def status(rental)
    if rental.scheduled?
      content_tag(:span, class: 'badge badge-success') do
        'Agendada'
      end
    end
  end
end
