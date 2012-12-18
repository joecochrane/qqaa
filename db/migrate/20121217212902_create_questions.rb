class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :id
      t.integer :user_id
      t.text :text
      t.boolean :deleted
      t.string :tags
      t.integer :qcat
      t.text :qupvotesfrom
      t.integer :qupvotesfromcount
      t.integer :answercount

      t.timestamps
    end
  end
end
