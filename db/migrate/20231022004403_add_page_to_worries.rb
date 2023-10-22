# \\wsl.localhost\Ubuntu\home\aivets\projects\worryaway\db\migrate\20231022004403_add_page_to_worries.rb

class AddPageToWorries < ActiveRecord::Migration[7.0]
  def change
    add_column :worries, :page, :string
  end
end
