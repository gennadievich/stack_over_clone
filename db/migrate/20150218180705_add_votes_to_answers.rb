class AddVotesToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :votes, :integer, default: 0
  end
end
