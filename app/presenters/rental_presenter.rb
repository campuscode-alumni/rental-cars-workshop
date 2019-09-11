class RentalPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def initialize(rental)
    super(rental)
  end

  def status()
    if scheduled?
      h.content_tag(:span, class: 'badge badge-success') do
        "Agendada"
      end
    end
  end

  def withdraw_link
    if scheduled?
      h.link_to 'Confirmar Retirada', withdraw_rental_path(id), method: :post
    end
  end

  private
  def h
    ApplicationController.helpers
  end
end
