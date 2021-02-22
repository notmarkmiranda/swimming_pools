class SessionsController < Devise::SessionsController
  def new
    super do
      @no_navbar = true
    end
  end
end
