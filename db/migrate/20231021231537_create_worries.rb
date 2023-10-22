# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\db\migrate\20231021231537_create_worries.rb

class CreateWorries < ActiveRecord::Migration[7.0]
  def change
    create_table :worries do |t|
      t.references :user, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
