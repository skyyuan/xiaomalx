class AddProfeChildrenIdToQuestionTags < ActiveRecord::Migration
  def change
    add_column :question_tags , :profe_children_id, :integer
  end
end
