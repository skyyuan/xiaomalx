class CreateAdvisoryInformations < ActiveRecord::Migration
  def change
    create_table :advisory_informations do |t|
      t.string :destination
      t.string :education
      t.string :professional
      t.string :funds
      t.string :school
      t.string :studying_professional
      t.string :gpa
      t.string :text_type
      t.string :results
      t.string :ranking
      t.string :academic
      t.string :employment
      t.string :resettlement
      t.string :preference
      t.integer :elder_id
      t.timestamps
    end
  end
end
