class VotesController < ApplicationController

  def new


  end

  def create
    @user = current_user

  end
end
