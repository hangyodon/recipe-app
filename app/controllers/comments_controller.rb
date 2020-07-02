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
    @comments_count = Comment.where(recipe_id: @recipe.id).count
  end

  def destroy
    Comment.find_by(id: params[:id],recipe_id: params[:recipe_id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to root_path
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end
end
