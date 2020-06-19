class RecipesController < ApplicationController

  before_action :move_to_index, except: [:index, :show, :search, :main, :side, :soup]
  def index
    if params[:tag]
      @recipes = Recipe.tagged_with(params[:tag])
    else
      @recipes = Recipe.page(params[:page]).per(4).order("created_at DESC")
    end

    if params[:tag_name]
      @recipes = Recipe.tagged_with("#{params[:tag_name]}").page(params[:page]).per(4)
    end
    # @tags = Recipe.tag_counts_on(:tags).order('count DESC')
    @popular_tags = ActsAsTaggableOn::Tag.most_used(8)   
  end

  def main
    @recipes = Recipe.where(category: "main")
  end

  def side
    @recipes = Recipe.where(category: "side")
  end

  def soup
    @recipes = Recipe.where(category: "soup")
  end

  def new
    @recipe = Recipe.new
    @recipe.materials.build
    @recipe.steps.build
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to root_path, notice: '投稿が完了しました'
    else
      render :new
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    recipe = Recipe.find(params[:id])
    if recipe.update(recipe_params)
      redirect_to root_path, notice: '編集が完了しました'
    else
      redirect_to root_path, alert: '編集に失敗しました'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @favorite = Favorite.new
    @favorites_count = Favorite.where(recipe_id: @recipe.id).count
    @comment = Comment.new
    @comments = @recipe.comments.includes(:user)
    @comments_count = Comment.where(recipe_id: @recipe.id).count
    @reports_count = Report.where(recipe_id: @recipe.id).count
  end

  def search
    redirect_to root_path if params[:keyword] == ""
    split_keyword = params[:keyword].split(/[[:blank:]]+/)
    @recipes = []
    split_keyword.each do |keyword|
      next if keyword == ""
      @recipes += Recipe.joins(:materials).where('recipes.title LIKE (?) AND materials.name LIKE (?)', "%#{keyword}%", "%#{keyword}%")
    end
    @recipes.uniq!
    @recipes = Recipe.page(params[:page]).per(4).order("created_at DESC")
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :category, :image, :calorie, :sugar, :tag_list,  materials_attributes: [:id, :name, :amount, :_destroy], steps_attributes: [:id, :number, :process, :_destroy]).merge(user_id: current_user.id)
  end

  def update_recipe_params
    params.require(:recipe).permit(:title, :category, :image, :calorie, :sugar, :tag_list, materials_attributes: [:name, :amount, :_destroy, :id], steps_attributes: [:number, :process, :_destroy, :id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end