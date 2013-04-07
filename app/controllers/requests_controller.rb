class RequestsController < ApplicationController

  def new
    @request = Request.new

  end

  def create
    @request = Request.create(params[:request])
  end


  def show
  end

  def search
  end

end
