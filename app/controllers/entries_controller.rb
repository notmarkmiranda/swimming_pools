class EntriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @pool = current_user.participating_pools.find(params[:pool_id])
    @entry = @pool.entries.find(params[:id]).decorate
    # authorize @pool
    @questions = @pool.questions
    # @questions.count.times { @entry.picks.build }
  end

  def create
    @pool = current_user.participating_pools.find(params[:pool_id])
    @entry = @pool.entries.new(user: current_user)
    if @entry.save
      redirect_to pool_entry_path(@pool, @entry)
    else
      redirect_to pool_path(@pool)
    end
  end

  def update
    @pool = current_user.participating_pools.find(params[:pool_id])
    @entry = Entry.find(params[:id])
    # authorize entry
    @entry.update(entry_params)
    redirect_to pool_entry_path(@pool, @entry)
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :pool_id, pick: [:choice_id])
  end
end
