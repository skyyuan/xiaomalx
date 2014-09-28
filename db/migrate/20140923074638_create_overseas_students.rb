class CreateOverseasStudents < ActiveRecord::Migration
  def change
    create_table :overseas_students do |t|

      t.integer :code,null: false
      t.string :name,null: false
      t.string :phone,null: false
      t.string :relationship,null: false
      t.string :contact_name
      t.string :contact_phone

      t.text :background
      t.string :student_status,null: false,default:0 #0:表示跟进中，1：常规，2：紧急，3：即将到访
      t.string :comment

      t.integer :fllow_up_status,null: false,default:0 #0:表示跟进中，1：已签，2：无效

      t.string :sign_amount,null: false,default:0
      t.string :sign_commission_discount,null: false,default:0
      t.string :sign_return_amount,null: false,default:0
      t.datetime :sign_return_date

      t.string :renew_amount,null: false,default:0
      t.string :renew_commission_discount,null: false,default:0
      t.string :renew_return_amount,null: false,default:0
      t.datetime :renew_return_date

      t.string :return_amount,null: false,default:0

      t.integer :creator_id

      t.timestamps
    end
  end
end
