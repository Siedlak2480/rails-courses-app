class Course < ApplicationRecord
  belongs_to :place
  has_many :participants, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2 }
end