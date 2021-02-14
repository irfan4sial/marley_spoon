require 'contentful'
class RecipesController < ApplicationController
  before_action :set_client, only: [:index, :show]

  def index
    @recipes = @client.entries(content_type: 'recipe')
    @recipes.each do |entry|
      puts entry.fields.inspect
      puts "============================================="
      puts entry.id.inspect
      puts entry.title.inspect
      puts entry.photo.url.inspect
      puts entry.description.inspect
      puts entry.fields.key?(:tags).inspect
      tags = entry.fields.key?(:tags) ? entry.tags : []
      puts tags.inspect
      tags.each_with_index do |tag, index|
        puts "tag = #{index} ---- #{tag.fields.inspect}"
      end
      puts "Chef keys ===== #{entry.fields.key?(:chef)}"
      chef = entry.fields.key?(:chef) ? entry.chef.fields : ''
      puts "Chef ------ #{chef.inspect}"
      puts chef.inspect
      puts "============================================="
    end
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
