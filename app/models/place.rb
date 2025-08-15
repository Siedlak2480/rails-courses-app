class Place < ApplicationRecord
  has_many :courses, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }
end