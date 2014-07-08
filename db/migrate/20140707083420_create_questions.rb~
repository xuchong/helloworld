class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :questionnaire_id
      t.integer :q_type
      t.string :q_content
      t.string :q_choice
      t.integer :q_index
      t.string :data

      t.timestamps
    end
  end
end
