class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :user_count
    end
  end
end
