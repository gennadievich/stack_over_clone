class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes, id:false do |t|
      t.integer :user_id
      t.integer :question_id
      t.string :vote


    end
  end
end
