class HomeController < ApplicationController
  before_filter :authenticate_student_admin!
    def index
      # render "index"
    end
end
