class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @pool = Pool.find(membership_params[:pool_id])
    return redirect_to membership_pool_path(@pool) unless invite_code_correct?
    @membership = current_user.memberships.new(pool: @pool)
    @membership.save
    redirect_to pool_path(@pool)
  end

  def destroy
    @membership = Membership.find(params[:id])
    authorize @membership
    pool = @membership.pool
    @membership.destroy!
    redirect_to pool
  end

  private

  def membership_params
    params.require(:membership).permit(:pool_id, :role, :invite_code)
  end

  def invite_code_correct?
    membership_params["invite_code"].downcase == @pool.invite_code.downcase
  end
end
