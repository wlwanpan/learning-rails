class Subber < ApplicationRecord

  has_many :stats, dependent: :destroy, autosave: true
  validates_associated :stats

  validates :server_name, uniqueness: true, presence: true, length: { minimum: 5 }
  validates :server_location, :server_alias, presence: true, length: { minimum: 5 }
  validates :key, presence: true

end
