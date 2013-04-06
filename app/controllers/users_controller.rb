class UsersController < ApplicationController

  def show
    @clubs = Club.all
  end

end
