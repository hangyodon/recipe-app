class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]


  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @recipes = user.recipes.page(params[:page]).per(4).order("created_at DESC")
  end

  def favorites
    user = User.find(params[:id])
    @nickname = user.nickname
  end

end
