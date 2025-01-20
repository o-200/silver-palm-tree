class Podcast < ApplicationRecord
  has_one_attached :photo
  has_one_attached :audio

  validates :title, presence: true
  validates :title, length: { minimum: 2 }

  def self.random_by_day
    podcast_count = count
    return if podcast_count.zero?
    new_random_podcast = offset(rand(podcast_count)).first
    cached_random_podcast_id = Rails.cache.fetch("random_podcast_id", expires_in: 1.days) { new_random_podcast.id }
    find_by(id: cached_random_podcast_id)
  end
end
