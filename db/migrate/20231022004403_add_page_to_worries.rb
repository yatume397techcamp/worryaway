class AddPageToWorries < ActiveRecord::Migration[7.0]
  def change
    add_column :worries, :page, :string
  end
end
