class AddMsgContentToMessages < ActiveRecord::Migration
  def change
    add_column :messages , :msg_content, :string
  end
end
