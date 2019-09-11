class RentalDecorator < ApplicationDecorator
  delegate_all

  def started_at
    return '---' if scheduled?
    return started_at if active?
  end
end
