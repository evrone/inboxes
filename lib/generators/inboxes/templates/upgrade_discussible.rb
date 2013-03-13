class UpgradeDiscussibleInboxes < ActiveRecord::Migration
  def self.change
    add_column :discussions, :discussible_id, :integer
    add_index :discussions, :discussible_id
  end

  def self.down
    remove_column :discussions, :discussible_id
  end
end
