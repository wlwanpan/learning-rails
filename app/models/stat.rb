class Stat < ApplicationRecord

  belongs_to :subber
  validates :data_title, presence: true

end
