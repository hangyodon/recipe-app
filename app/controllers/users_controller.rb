class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @recipes = user.recipes.page(params[:page]).per(4).order("created_at DESC")
  end
end
