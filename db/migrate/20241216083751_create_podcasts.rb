class CreatePodcasts < ActiveRecord::Migration[7.2]
  def change
    create_table :podcasts do |t|
      t.string "title", limit: 100
      t.text "description"

      t.timestamps
    end
  end
end
