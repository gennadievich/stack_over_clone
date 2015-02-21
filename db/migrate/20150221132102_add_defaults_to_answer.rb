class AddDefaultsToAnswer < ActiveRecord::Migration
  def change
    change_column_default :answers, :rating, 0

    Answer.all.each do |a|

      if a.rating.nil?
        a.rating = 0
        a.save
      end

    end
  end
end
