class RentalPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  delegate :content_tag, :link_to, to: :h

  def initialize(rental)
    super(rental)
  end

  def status
    return content_tag(:span, class: 'badge badge-success') do
      'Agendada'
    end if scheduled?

    return content_tag(:span, class: 'badge badge-primary') do
      'Em andamento'
    end if active?

    ''
  end

  def withdraw_link
    if scheduled?
      return h.link_to 'Confirmar Retirada', withdraw_rental_path(id), 
        method: :post
    end

    ''
  end

  private

  def h
    ApplicationController.helpers
  end
end
