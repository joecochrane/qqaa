class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :id
      t.integer :user_id
      t.integer :answer_id
      t.integer :question_id
      t.text :text

      t.timestamps
    end
  end
end
