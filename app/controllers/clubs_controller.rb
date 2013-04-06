class ClubsController < ApplicationController

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(name: params[:club][:name])
    # @user = current_user

    binding.pry
  end

  def show

  end

end
