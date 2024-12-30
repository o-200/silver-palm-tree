class Podcast < ApplicationRecord
  has_one_attached :photo
  has_one_attached :audio

  validates :title, presence: true
  validates :title, length: { minimum: 2 }
end
