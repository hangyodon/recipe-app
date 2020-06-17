class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントを投稿しました"
    redirect_to root_path
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @comments = @recipe.comments.includes(:user)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end
end

# /recipes/#{comment.recipe.id}"