class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    company = Company.find(params[:id])
    prices = company.prices.days(30).order(:timestamp).map{|p| [p.timestamp.try(:strftime, "%Y-%m-%d"), p.price]}
    prices_hash = Hash[prices]
    price_max = prices_hash.map{|k,v| v}.max
    price_min = prices_hash.map{|k,v| v}.min
    respond_to do |format|
      format.json { render :json => {company: company,
                                     prices: prices_hash,
                                     price_max: price_max,
                                     price_min: price_min} }
    end
  end
end
