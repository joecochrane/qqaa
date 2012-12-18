class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :id
      t.integer :user_id
      t.integer :question_id
      t.text :text
      t.integer :category
      t.boolean :deleted
      t.text :aupvotesfrom
      t.integer :aupvotesfromcount

      t.timestamps
    end
  end
end
