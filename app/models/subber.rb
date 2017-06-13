class Subber < ApplicationRecord

  has_many :statistics, dependent: :destroy, autosave: true
  validates_associated :statistics

  #Here you are doing the validate to ensure uniqueness. IF the model fails validation your users should get an alert.
  validates :server_name, uniqueness: true, presence: true, length: { minimum: 5 }
  validates :server_location, :server_alias, presence: true, length: { minimum: 5 }
  validates :key, presence: true

end
