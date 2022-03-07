class DropPlaylistsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :playlists
  end
end
