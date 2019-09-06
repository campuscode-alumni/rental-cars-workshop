class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    render json: 'Not found', status: :not_found
  end
end
