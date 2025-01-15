class Podcast < ApplicationRecord
  RANDOM_BY_DAY_DATA = {id: 1, time: Time.current}

  has_one_attached :photo
  has_one_attached :audio

  validates :title, presence: true
  validates :title, length: { minimum: 2 }


  scope :random_by_day, ->() do
    return find(RANDOM_BY_DAY_DATA[:id]) if Time.current < RANDOM_BY_DAY_DATA[:time] + 1.minutes#1.days
    new_random_podcast = random
    RANDOM_BY_DAY_DATA[:id], RANDOM_BY_DAY_DATA[:time] = new_random_podcast.id, Time.current
    new_random_podcast
  end

  scope :random, ->() do
    offset(rand(Podcast.count)).first
  end

end
