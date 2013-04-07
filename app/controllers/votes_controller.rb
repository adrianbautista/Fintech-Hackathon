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
  end
end
