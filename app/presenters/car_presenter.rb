class CarPresenter < SimpleDelegator
  attr_reader :user

  def initialize(car, user, policy = nil)
    super(car)
    @user = user
    @policy = policy || MaintenancePolicy.new(car, user)
  end

  def maintenance_link
    return '' if rented?
    return '' unless policy.authorized?
    if available?
      return h.link_to "Enviar para manutenção", new_car_maintenance_path(id)
    end
    h.link_to "Dar baixa em manutenção", new_return_maintenance_path(current_maintenance)
  end
end
