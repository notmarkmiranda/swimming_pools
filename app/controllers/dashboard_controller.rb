class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @pools = current_user.participating_pools.decorate
  end
end
