class RequestsController < ApplicationController

  def new
    @request = Request.new
    @club_id = params[:id]
  end

  def create
    @request = Request.create(params[:request])
    Club.find(@request.club_id).members.each do |user|
      Vote.create(request_id: @request.id, user_id: user.id, club_id: @request.club_id)
    end
    redirect_to club_path(@request.club)
  end

  def show
  end

  def search
  end

end
