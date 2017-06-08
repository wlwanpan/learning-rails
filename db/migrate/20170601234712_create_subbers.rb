class CreateSubbers < ActiveRecord::Migration[5.1]
  def change
    create_table :subbers do |t|
      t.string :subber_name
      t.string :subber_location
      t.string :subber_alias

      t.timestamps
    end
  end
end
