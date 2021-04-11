class Api::V1::HealthcheckController < Api::ApiController
  skip_before_action :api_authorized
  
  def show
    render status: 200, json: { message: "all is well, check again later." }
  end
end