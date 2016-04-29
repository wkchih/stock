class PricesController < ApplicationController

  def create
    @price = Company.find(params[:company_id]).prices.new
    @price.price = params[:price]
    @price.timestamp = Time.now

    if @price.save
      render json: {@price.timestamp.try(:strftime, "%Y-%m-%d") => @price.price}
    else
      render json: @price.errors, status: :unprocessable_entity
    end
  end
end