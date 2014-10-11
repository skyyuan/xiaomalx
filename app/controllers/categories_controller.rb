class CategoriesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    categories = Category.where(parent_id: nil).group("name")
    data = []
    categories.each do |category|
      data1 = []
      category.children.each do |child|
        if child.children.present?
          data2 = []
          child.children.each do |c|
            data2 << {'id' => c.id, 'name' => c.name}
          end
          data1 << {'id' => child.id, 'name' => child.name, 'child' => data2}
        else
          data1 << {'id' => child.id, 'name' => child.name, 'child' => []}
        end
      end
      data << {category.name => data1}
    end
    render :json => {:result => "1", :categories => data}
  end
end