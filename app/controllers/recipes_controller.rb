class RecipesController < ApplicationController

  before_action :move_to_index, except: [:index, :show, :search]
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

  def new
    @recipe = Recipe.new
    @recipe.materials.build
    @recipe.steps.build
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
    redirect_to root_path
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
    recipe.update(recipe_params)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @favorite = Favorite.new
    @favorites_count = Favorite.where(recipe_id: @recipe.id).count
  end

  def search
    @recipes = Recipe.search(params[:keyword])
    @recipes = @recipes.page(params[:page])
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :image, :calorie, :sugar, :tag_list, materials_attributes: [:id, :name, :amount, :_destroy], steps_attributes: [:id, :number, :process, :_destroy]).merge(user_id: current_user.id)
  end

  def update_recipe_params
    params.require(:recipe).permit(:title, :image, :calorie, :sugar, :tag_list, materials_attributes: [:name, :amount, :_destroy, :id], steps_attributes: [:number, :process, :_destroy, :id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end