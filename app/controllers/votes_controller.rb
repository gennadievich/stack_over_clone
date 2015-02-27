class VotesController < ApplicationController

  before_action :authenticate_user

  def perform_vote_for
    smth = params[:what].constantize.find(params[:id])
    how  = params[:how]
    if user_created smth
      redirect_to :back                                       # Here must be notification: "You can't vote for your creation!"
    else
      if how == 'up'
        if smth.votes.where('vote = ? and user_id =?', how, current_user.id).count == 0
          smth.votes.where('vote = ? and user_id =?', 'down', current_user.id).delete_all if smth.votes.where('vote = ? and user_id =?', 'down', current_user.id).count != 0
          smth.votes <<  Vote.new(vote: how, user_id: current_user.id)
          smth.rating = smth.score
          smth.save
          redirect_to :back
        else
          redirect_to :back                                   #Already voted
        end

      elsif how == 'down'
        if smth.votes.where('vote = ? and user_id =?', how, current_user.id).count == 0
          smth.votes.where('vote = ? and user_id =?', 'up', current_user.id).delete_all if smth.votes.where('vote = ? and user_id =?', 'up', current_user.id).count != 0
          smth.votes << Vote.new(vote: how, user_id: current_user.id)
          smth.rating = smth.score
          smth.save
          redirect_to :back
        else
          redirect_to :back                                   #Already voted
        end
      end
    end
  end

  def unvote
    smth = params[:what].constantize.find(params[:id])
    smth.votes.where('user_id =?', current_user.id).delete_all
    smth.save
    redirect_to :back
  end

  private

  def user_created(what)
    what.user == current_user
  end

end
