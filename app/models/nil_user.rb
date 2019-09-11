class NilUser
  def admin?
    false
  end

  def manager?
    false
  end

  def rentals
    []
  end

  def guest?
    true
  end
end
