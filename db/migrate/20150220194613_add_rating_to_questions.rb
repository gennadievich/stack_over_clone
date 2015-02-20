class AddRatingToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :rating, :integer
  end
end
