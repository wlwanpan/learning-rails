class RenameUserTableToStat < ActiveRecord::Migration[5.1]
  def change
    rename_table :users, :stats
  end
end
