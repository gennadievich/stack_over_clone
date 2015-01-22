class AddDefaultsToQuestion < ActiveRecord::Migration
  def change
    change_column_default :questions, :views, 0
    change_column_default :questions, :votes, 0

    Question.all.each do |q|

      if q.votes.nil?
        q.votes = 0
      end

      if q.views.nil?
        q.views = 0
      end

      q.save
    end
  end
end
