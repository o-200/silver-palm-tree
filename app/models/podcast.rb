class Podcast < ApplicationRecord
  has_one_attached :photo
  has_one_attached :audio

  validates :title, presence: true
  validates :title, length: { minimum: 2 }


  scope :random_by_day, ->() do
    find Rails.cache.fetch('random_podcast', expires_in: 1.minutes) { random.id }
  end

  scope :random, ->() do
    offset(rand(Podcast.count)).first
  end

end
