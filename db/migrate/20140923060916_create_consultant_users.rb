class CreateConsultantUsers < ActiveRecord::Migration
  def change

    create_table(:consultant_users, primary_key: 'uid') do |t|
      t.string :email,             null: false, default: ""
      t.string :phone,             null: false, index: true,unique: true
      t.string :token
      t.string :name,              null: false
      t.string :encrypted_password, null: false
      t.string :invitation_code, null: false
      t.string :institution_name, null: false
      t.integer :is_public, null: false, default:0  #1,Pubic,0 Privace
      t.string :education_id, null: false
      t.string :professional_id, index: false
      t.string :country_id, index: false
      t.timestamps
    end

  end
end

# {
#   Status:test,
#   Message:test,
#   Time:test,
#   Content:{
#   }
# }

