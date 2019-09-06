class Api::V1::ManufacturesController < Api::V1::ApiController
  def create
    manufacture = Manufacture.new(name: params[:name])
    return render json: manufacture, status: :created if manufacture.save

    render json: manufacture.errors.full_messages, status: :precondition_failed
  end
end
