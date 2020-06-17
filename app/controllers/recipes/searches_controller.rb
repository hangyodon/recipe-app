class Recipes::SearchesController < ApplicationController
  def index
    redirect_to root_path if params[:keyword] == ""
    split_keyword = params[:keyword].split(/[[:blank:]]+/)
    @recipes = []
    split_keyword.each do |keyword|
      next if keyword == ""
      @recipes += Recipe.joins(:materials).where('recipes.title LIKE (?) AND materials.name LIKE (?)', "%#{keyword}%", "%#{keyword}%")
    end
    @recipes.uniq!
  end
end
