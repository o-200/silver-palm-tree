class Podcast < ApplicationRecord
  has_one_attached :photo
  has_one_attached :audio

  belongs_to :user

  validates :title, presence: true
  validates :title, length: { minimum: 2 }
end
