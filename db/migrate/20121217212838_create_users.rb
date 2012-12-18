class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.string :name
      t.string :email
      t.string :password
      t.string :encrypted_password
      t.boolean :admin
      t.boolean :banned
      t.text :upvotesfrom
      t.text :upvotesto
      t.text :qupvotesto
      t.text :aupvotesto
      t.string :salt
      t.string :location
      t.text :background

      t.timestamps
    end
  end
end
