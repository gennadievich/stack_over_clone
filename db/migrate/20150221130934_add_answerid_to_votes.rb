class AddAnsweridToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :answer_id, :integer
  end
end
