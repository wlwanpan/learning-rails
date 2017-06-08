class Subber < ApplicationRecord

  has_many :stats, dependent: :destroy, autosave: true
  validates_associated :stats

  validates :subber_name, uniqueness: true, presence: true, length: { minimum: 5 }
  validates :subber_location, :subber_alias, presence: true, length: { minimum: 5 }

end
