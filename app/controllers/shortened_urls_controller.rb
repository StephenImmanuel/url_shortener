require 'url_shortener'

class ShortenedUrlsController < ApplicationController
  before_action :set_shortened_url, only: [:show, :edit, :update, :destroy]

  def new
    @shortened_url = ShortenedUrl.new
  end

  def create
    @shortened_url = ShortenedUrl.new(shortened_url_params)
    @minify_url = UrlShortener::MinifyUrl.new(shortened_url_params[:url], request.base_url)
    @shortened_url.short_url = @minify_url.minify

    respond_to do |format|
      if @shortened_url.save
        format.html { redirect_to @shortened_url, notice: 'Shortened url was successfully created.' }
        format.json { render :show, status: :created, location: @shortened_url }
      elsif @shortened_url.errors[:url].include? 'has already been taken'
        @shortened_url = ShortenedUrl.find_by_url(shortened_url_params[:url]);
        format.html { redirect_to @shortened_url, notice: 'Shortened url was successfully created.' }
        format.json { render :show, status: :created, location: @shortened_url }      
      else
        format.html { render :new }
        format.json { render json: @shortened_url.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shortened_url
      @shortened_url = ShortenedUrl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shortened_url_params
      params.require(:shortened_url).permit(:url)
    end
end
