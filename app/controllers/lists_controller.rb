require 'json'
require 'open-uri'

class ListsController < ApplicationController

  before_action :find_list, only: %i[ show destroy ]

  def index
    @films = call_api["backdrop_path"]
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(permission)
    if @list.save
      redirect_to list_path(@list.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @list.destroy
      redirect_to lists_path
    else
      redirect_to lists_path, status: :unprocessable_entity
    end
  end
  private

  def find_list
    @list = List.find(params[:id])
  end

  def call_api
    url = "https://tmdb.lewagon.com/movie/top_rated"
    user_serialized = URI.open(url).read
    JSON.parse(user_serialized)
  end

  def permission
    params.require(:list).permit(:name)
  end
end
