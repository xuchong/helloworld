class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.integer :user_id
      t.string :qa_title
      t.string :qa_subject
      t.string :qa_description
      t.integer :qa_is_anonymous
      t.integer :qa_ip_limit
      t.integer :qa_status
      t.string :qa_special_list
      t.integer :qa_user_limit

      t.timestamps
    end
  end
end
