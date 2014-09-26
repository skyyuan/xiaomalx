class CategoriesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    categories = Category.where(parent_id: nil).group("name")
    data = []
    categories.each do |category|
      data_json = {}
      data_json.merge!(category.name => [
            'children' => category.children
            ])
      data << data_json
    end
    render :json => {:result => "1", :categories => data} and return
  end

  def profe_children_tags
    profe = Category.where(parent_id: params[:id])
    render :json => profe and return

  end
end