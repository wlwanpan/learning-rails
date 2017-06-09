class Statistic < ApplicationRecord

  belongs_to :subber
  validates :data_title, :date, presence: true

end
