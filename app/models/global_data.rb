class GlobalData < ApplicationRecord

  # Not sure where this is used? There is no table backing this model

  # Also it seems like active_users, total_queries, entries_deleted are all computed state, meaning you could derive these numberbs by looking at your raw data.
  # When possible I prefer computed state over trying to manage the state myself. There are often less bugs. If u tried to track  all of this manually it just takes one bug for everything to get our of sync.
  validates :active_users, :database_collection, :total_queries, :entries_deleted, :last_update, presence: true

end
