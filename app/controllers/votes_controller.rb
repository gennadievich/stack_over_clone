class VotesController < ApplicationController

  before_action :authenticate_user
  after_action :set_rating, only: [:perform_vote_for]

  def perform_vote_for
    smth = params[:what].constantize.find(params[:id])
    how  = params[:how]
    if user_created smth
      redirect_to :back                                       # Here must be notification: "You can't vote for your creation!"
    else
      if how == 'up'
        if smth.votes.where('vote = ? and user_id =?', how, current_user.id).count == 0
            if smth.votes.where('vote = ? and user_id =?', 'down', current_user.id).count != 0
              smth.votes.where('vote = ? and user_id =?', 'down', current_user.id).delete_all
            end
          smth.votes <<  Vote.new(vote: how, user_id: current_user.id)
          smth.save
          redirect_to :back
        else
          redirect_to :back                                   #Already voted
        end

      elsif how == 'down'
        if smth.votes.where('vote = ? and user_id =?', how, current_user.id).count == 0
          if smth.votes.where('vote = ? and user_id =?', 'up', current_user.id).count != 0
            smth.votes.where('vote = ? and user_id =?', 'up', current_user.id).delete_all
          end
          smth.votes << Vote.new(vote: how, user_id: current_user.id)
          smth.save
          redirect_to :back
        else
          redirect_to :back                                   #Already voted
        end
      end
    end
  end

  private

  def set_rating
    smth = params[:what].constantize.find(params[:id])
    smth.rating = smth.score
    smth.save
  end

  def user_created(what)
    what.user == current_user
  end

end
