class EntryDecorator < ApplicationDecorator
  delegate_all

  def status
    entry.picks.count == entry.pool.questions.count ? "Complete" : "Incomplete"
  end

end
