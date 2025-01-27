class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :podcasts, dependent: :destroy
  has_many :subscriptions
  has_many :subscribed_podcasts, through: :subscriptions, source: :podcast

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, uniqueness: true

  def subscribe_to_podcast(podcast)
    subscriptions.create(podcast: podcast)
  end
  
  def unsubscribe_from_podcast(podcast)
    subscriptions.find_by(podcast: podcast)&.destroy
  end
end
