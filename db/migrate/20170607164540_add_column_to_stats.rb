class AddColumnToStats < ActiveRecord::Migration[5.1]
  def change
    add_column :stats, :subber_id, :integer
  end
end
