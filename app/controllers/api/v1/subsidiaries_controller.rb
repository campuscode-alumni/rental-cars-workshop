class Api::V1::SubsidiariesController < Api::V1::ApiController
  def index
    subsidiaries = Subsidiary.all
    render json: subsidiaries
  end
end
