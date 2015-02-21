class RemoveVotesFromAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :votes
  end
end
