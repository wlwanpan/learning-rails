class AddDataTitleToStats < ActiveRecord::Migration[5.1]
  def change
    add_column :stats, :data_title, :string
  end
end
