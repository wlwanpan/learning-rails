class GlobalData < ApplicationRecord

  validates :active_users, :database_collection, :total_queries, :entries_deleted, :last_update, presence: true

end
