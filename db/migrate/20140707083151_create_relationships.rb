class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.string :questionnaire_id
      t.string :ip

      t.timestamps
    end
  end
end
