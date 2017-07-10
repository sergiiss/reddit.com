class RenameVoteTablesToVotes < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :vote_tables, :votes
  end

  def self.down
    rename_table :votes, :vote_tables
  end
end
