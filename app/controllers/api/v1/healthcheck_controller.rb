class Api::V1::HealthcheckController < Api::ApiController
  def show
    render status: 200, json: { message: "all is well, check again later." }
  end
end