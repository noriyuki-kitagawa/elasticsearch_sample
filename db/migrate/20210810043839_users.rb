class Users < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :sex, null: false
      t.string :account_id, null: false
      t.timestamps
    end
  end
end
