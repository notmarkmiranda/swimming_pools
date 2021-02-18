class PoolDecorator < ApplicationDecorator
  delegate_all

  def status
    if started_at.nil?
      "Not Started"
    elsif completed
      "Complete"
    else
      "In Progress"
    end
  end

end
