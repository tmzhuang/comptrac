class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def landing
    if user_signed_in?
      redirect_to current_user
    end
  end
end
