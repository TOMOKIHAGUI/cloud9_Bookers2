class RemoveFollowerdIdFromRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :followerd_id, :integer
  end
end
