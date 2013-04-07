class VotesController < ApplicationController

  def new
  end

  def create
    @user = current_user
  end

  def update
    @vote = Vote.find(params[:id])
    @vote.update_attributes(value: params[:value])

    ## look for math to see if majority rules, then place trade
    if @vote.request.votes.where(value: true).count/@vote.request.club.members.count > .5
      @vote.request.update_attributes(status: 'Ordered')
    end
  end
end
