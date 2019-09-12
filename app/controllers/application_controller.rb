class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_user
    super || NilUser.new
  end

  def user_signed_in?
    return false if current_user.guest?

    super
  end
end
