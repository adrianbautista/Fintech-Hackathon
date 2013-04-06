class UsersController < ApplicationController

  def show
    @clubs = Club.order("created_at DESC")
  end

end
