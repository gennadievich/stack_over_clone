class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.integer :votes
      t.integer :views

      t.timestamps
    end
  end
end
