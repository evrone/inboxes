class InstallInboxes < ActiveRecord::Migration
  def self.up
    create_table :discussions do |t|
      t.integer :messages_count, :default => 0 # counter cache
      t.references :discussable, :polymorphic => true
      t.timestamps
    end

    create_table :messages do |t|
      t.references :user
      t.references :discussion
      t.text :body

      t.timestamps
    end

    create_table :speakers do |t|
      t.references :user
      t.references :discussion

      t.timestamps
    end

    add_index :discussions, [ :discussable_id, :discussable_type ], :name => 'discussions_discussable_idx'
    add_index :messages, :user_id
    add_index :messages, :discussion_id
    add_index :speakers, :user_id
    add_index :speakers, :discussion_id
  end

  def self.down
    drop_table :speakers
    drop_table :discussions
    drop_table :messages
  end
end
