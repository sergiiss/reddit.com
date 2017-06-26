class CreateVoteTables < ActiveRecord::Migration[5.0]
  def change
    create_table :vote_tables do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :vote_type

      t.timestamps
    end
  end
end
