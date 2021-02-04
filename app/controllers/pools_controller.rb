class PoolsController < ApplicationController
  before_action :authenticate_user!

  def show
    @pool = current_user.pools.find(params[:id])
  end

  def new
    @pool = current_user.pools.new
  end

  def create
    @pool = current_user.pools.new(pool_params)
    if @pool.save
      redirect_to @pool
    else
      render :new
    end
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :associated_game, :date, :multiple_entries, :completed, :invite_code)
  end
end
