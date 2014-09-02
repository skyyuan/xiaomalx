class HomeController < ApplicationController
  before_filter :authenticate_user!
    # layout "admin"
    def index
      render "index"
    end
end
