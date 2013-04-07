class UsersController < ApplicationController

  def show
    @stake = current_user.deposits.map(&:amount).inject(&:+)
    @clubs = Club.order("created_at DESC")
  end

end
