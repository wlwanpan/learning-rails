class ChangeStatTableToStatistic < ActiveRecord::Migration[5.1]
  def change
    rename_table :stats, :statistics
  end
end
