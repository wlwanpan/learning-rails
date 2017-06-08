class AddDateColumnToStats < ActiveRecord::Migration[5.1]
  def change
    add_column :stats, :date, :integer
  end
end
