require 'contentful'
class RecipesController < ApplicationController
  before_action :set_client, only: [:index, :show]

  def index
    @recipes = @client.entries(content_type: 'recipe')
  end

  def show
    @recipe = @client.entry(params[:id])
    respond_to do |format|
      format.html
    end
  end

  private

  def set_client
    @client = Contentful::Client.new(space: ENV['SPACE_ID'],
                                     access_token: ENV['ACCESS_TOKEN'],
                                     dynamic_entries: :auto
    )
  end
end
