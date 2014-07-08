class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :user_id
      t.string :answer_content
      t.string :data

      t.timestamps
    end
  end
end
