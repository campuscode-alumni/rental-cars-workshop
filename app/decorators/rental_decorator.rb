class RentalDecorator < ApplicationDecorator
  delegate_all

  def started_at
    if scheduled?
      return '---'
    end
    return started_at if active?
  end
end
