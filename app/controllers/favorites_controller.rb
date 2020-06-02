class FavoritesController < ApplicationController
  before_action :authenticate_user

  # def create
  #   @favorite = Favorite.new(
  #     user_id: @current_user_id,
  #     recipe_id: params[:recipe_id]
  #   )
  #   @favorite.save
  #   redirect_to("/recipes/#{params[:recipe_id]}")
  # end

  # def destroy
  #   @favorite = Favorite.find_by(user_id: @current_user_id, recipe_id: params[:recipe_id])
  #   @favorite.destroy
  #   redirect_to("/recipes/#{params[:recipe_id]}")
  # end

end
