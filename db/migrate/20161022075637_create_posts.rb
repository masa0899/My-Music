class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string   :song_title
      t.string   :singer
      t.text     :youtube_url
      t.text     :text
      t.integer  :user_id

      t.timestamps
    end
  end
end
