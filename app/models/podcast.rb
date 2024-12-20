class Podcast < ApplicationRecord
  has_one_attached :photo
  has_one_attached :audio

  belongs_to :user
end
