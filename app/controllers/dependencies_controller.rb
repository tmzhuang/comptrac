class DependenciesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    render test: "TEST"
  end
end
