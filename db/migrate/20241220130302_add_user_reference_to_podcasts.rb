class AddUserReferenceToPodcasts < ActiveRecord::Migration[7.2]
  def change
    add_reference :podcasts, :user
  end
end
