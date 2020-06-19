class ReportsController < ApplicationController
  def new
    @report = Report.new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @report = Report.new(report_params)
    @recipe = Recipe.find(params[:recipe_id])
    
    if @report.save
      flash[:notice] = "レポートを投稿しました"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @reports = @recipe.reports.includes(:user)
    @reports = @reports.page(params[:page]).per(8).order("created_at DESC")
  end

  private
  def report_params
    params.require(:report).permit(:image,:text).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end
end
