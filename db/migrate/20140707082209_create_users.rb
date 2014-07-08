class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :user_email
      t.integer :user_age
      t.string :user_sex
      t.integer :user_status
      t.integer :user_is_admin
      t.string :user_job
      t.string :remember_token
      t.string :password_digest

      t.timestamps
    end
  end
end
