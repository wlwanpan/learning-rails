class RenamingSubberColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :subbers, :subber_name, :server_name
    rename_column :subbers, :subber_location, :server_location
    rename_column :subbers, :subber_alias, :server_alias
  end
end
