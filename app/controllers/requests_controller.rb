class RequestsController < ApplicationController

  def new
    @request = Request.new

  end

  def create
    request_attr = params[:request]
    @request = Request.new
    (params[:request])
  end


  def show


  end

end
