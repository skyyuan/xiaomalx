class CommonProblemsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    common_problems = CommonProblem.order("created_at desc").page(params[:page]).per(params[:page_per])
    render :json => common_problems
  end
end
