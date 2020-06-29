require 'rails_helper'
describe RecipesController, type: :controller do
  
  before do
    @user = FactoryBot.create(:user)
  end

  describe '#index' do
    it "@recipeに正しい値が入っていること" do
      recipes = create_list(:recipe, 3)
      get :index
      expect(assigns(:recipes)).to match(recipes.sort{ |a, b| b.created_at <=> a.created_at })
    end

    it "index.html.erbに遷移すること" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe '#main' do
    it "@recipeに正しい値が入っていること" do
      recipes = create_list(:recipe, 3)
      get :main
      expect(assigns(:recipes)).to match(recipes.sort{ |a, b| b.created_at <=> a.created_at })
    end

    it "main.html.erbに遷移すること" do
      get :main
      expect(response).to render_template :main
    end
  end

  describe '#side' do
    it "@recipeに正しい値が入っていること" do
      recipes = create_list(:recipe, 3, category: "side")
      get :side
      expect(assigns(:recipes)).to match(recipes.sort{ |a, b| b.created_at <=> a.created_at })
    end

    it "side.html.erbに遷移すること" do
      get :side
      expect(response).to render_template :side
    end
  end

  describe '#soup' do
    it "@recipeに正しい値が入っていること" do
      recipes = create_list(:recipe, 3, category: "soup")
      get :soup
      expect(assigns(:recipes)).to match(recipes.sort{ |a, b| b.created_at <=> a.created_at })
    end

    it "soup.html.erbに遷移すること" do
      get :soup
      expect(response).to render_template :soup
    end
  end

  describe '#new' do
    it "new.html.erbに遷移すること" do
      sign_in @user
      get :new
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    context "保存に成功した場合" do
      it "recipeを保存すること" do
        sign_in @user
        params = { materials_attributes: [ FactoryBot.attributes_for(:material) ], steps_attributes: [FactoryBot.attributes_for(:step) ] }
        expect {
          post :create,
          params: {recipe: FactoryBot.attributes_for(:recipe).merge(params)}
        }.to change(Recipe, :count).by(1).and change(Material, :count).by(1).and change(Step, :count).by(1)
      end

      it "root_pathへリダイレクトすること" do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end

    context "保存に失敗した場合" do
      RSpec::Matchers.define_negated_matcher :not_change, :change 
      it "recipeを保存しないこと" do
        sign_in @user
        params = { materials_attributes: [ FactoryBot.attributes_for(:material) ], steps_attributes: [FactoryBot.attributes_for(:step) ] }
        expect {
          post :create,
          params: {recipe: FactoryBot.attributes_for(:recipe, title: nil).merge(params)}
        }.to not_change(Recipe, :count).and not_change(Material, :count).and not_change(Step, :count)
      end

      it "再度作成ページへ遷移されること" do
        sign_in @user
        params = { materials_attributes: [ FactoryBot.attributes_for(:material) ], steps_attributes: [FactoryBot.attributes_for(:step) ] }
        post :create,
        params: {recipe: FactoryBot.attributes_for(:recipe, title: nil).merge(params)}
        expect(response).to render_template :new
      end
    end
  end

  describe '#destroy' do
    it "recipeを削除できること" do
      sign_in @user
      @recipe = FactoryBot.create(:recipe)
      expect {
        delete :destroy, params: {id: @recipe.id}
      }.to change(Recipe, :count).by(-1)
    end

    it "root_pathへリダイレクトされること" do
      @recipe = FactoryBot.create(:recipe)
      delete :destroy, params: {id: @recipe.id}
      expect(response).to redirect_to(root_path)
    end
  end

  describe '#edit' do 
    before do
      sign_in @user
    end

    it "@recipeに正しい値が入っていること" do
      recipe = create(:recipe)
      get :edit, params: { id: recipe }
      expect(assigns(:recipe)).to eq recipe
    end

    it "edit.html.erbに遷移すること" do
      recipe = create(:recipe)
      get :edit, params: { id: recipe }
      expect(response).to render_template :edit
    end
  end

  describe '#update' do
    before do
      sign_in @user
    end

    it "recipeを更新できること" do
      @recipe = create(:recipe)
      recipe_params = {title: "bbb"}
      patch :update, params: {id: @recipe.id, recipe: recipe_params}
      expect(@recipe.reload.title).to eq "bbb"
    end

    it "root_pathへリダイレクトされること" do
      @recipe = create(:recipe)
      recipe_params = {title: "bbb"}
      patch :update, params: { id: @recipe.id, recipe: recipe_params}
      expect(response).to redirect_to(root_path)
    end
  end

  describe '#show' do
    before do
      @recipe = create(:recipe)
    end

    it "@recipeに正しい値が入っていること" do
      get :show, params: { id: @recipe.id }
      expect(assigns(:recipe)).to eq @recipe
    end

    it "show.html.erbに遷移すること" do
      get :show, params: { id: @recipe.id }
      expect(response).to render_template :show
    end
  end

end
