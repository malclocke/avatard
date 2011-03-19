class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.string :email
      t.string :checksum
      t.string :avatar_uid

      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
