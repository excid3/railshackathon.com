class HomeController < ApplicationController
  def index
  end

  def terms
    render layout: "application"
  end

  def privacy
    render layout: "application"
  end
end
