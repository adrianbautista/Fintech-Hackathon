class RequestsController < ApplicationController

  def new
    @request = Request.new
    @club_id = params[:id]
  end

  def create
    @request = Request.create(params[:request])
    Club.find(@request.club_id).members.each do |user|
      vote = Vote.create(request_id: @request.id, user_id: user.id, club_id: @request.club_id)
    end
    # Vote.find(request_id)

    current_user.votes.where(request_id: @request.id).first.update_attributes(:value => true)

    ## look for math to see if majority rules, then place trade
    if @request.votes.where(value: true).count / @request.club.members.count > 0.5
      @request.update_attributes(status: 'Ordered')
    end

    redirect_to club_path(@request.club)
  end

  def show
  end

  def search
  end

end
