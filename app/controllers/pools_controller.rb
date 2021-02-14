class PoolsController < ApplicationController
  before_action :authenticate_user!

  def show
    @pool = current_user.participating_pools.find(params[:id])
    @questions = @pool.saved_questions
    @question = @pool.questions.new
    2.times { @question.choices.build }
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

  def edit
    @pool = current_user.pools.find(params[:id])
  end

  def update
    @pool = current_user.pools.find(params[:id])
    if @pool.update(pool_params)
      redirect_to @pool
    else
      render :edit
    end
  end

  def membership
    @pool = Pool.find(params[:id])
    @membership = current_user.memberships.new(pool_id: @pool.id)
  end



  private

  def pool_params
    params.require(:pool).permit(:name, :associated_game, :date, :multiple_entries, :completed, :invite_code)
  end
end
