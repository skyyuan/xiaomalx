class AddRecommendToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :recommend, :integer, default: 0
  end
end
