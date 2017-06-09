class AddKeyToSubber < ActiveRecord::Migration[5.1]
  def change
    add_column :subbers, :key, :string
  end
end
