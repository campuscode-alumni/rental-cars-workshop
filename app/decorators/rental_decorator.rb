class RentalDecorator < ApplicationDecorator
  delegate_all

  def started_at
    return '---' if scheduled?
    return I18n.l(super, format: :short) if active?
  end
end
