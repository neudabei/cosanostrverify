class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :public_key, null: false, index: true
      t.string :username, null: false, index: true
      t.string :public_key_hex

      t.timestamps
    end
  end
end
