class AddFkPodcastToUser < ActiveRecord::Migration[8.0]
  def change
    add_reference :podcasts, :user
  end
end
