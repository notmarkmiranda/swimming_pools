class PicksController < ApplicationController
  def create
    @pick = Pick.new(pick_params)
    if @pick.save
      redirect_to pool_entry_path(pool, entry)
    else
    end
  end

  private

  def pick_params
    params.require(:pick).permit(:entry_id, :choice_id, :correct, :points)
  end

  def pool
    entry&.pool
  end

  def entry
    @pick&.entry
  end
end
