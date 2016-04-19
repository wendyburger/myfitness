require 'spec_helper'

describe RecipesController do
  describe 'GET index' do
    it 'sets @recipes' do
      recipe1 = Fabricate(:recipe)
      recipe2 = Fabricate(:recipe)
      get :index
      expect(assigns(:recipes)).to match_array([recipe1, recipe2])
    end
  end

  describe 'GET new' do
    context 'with authenticated user' do
      it 'sets @recipe' do
        session[:user_id] = Fabricate(:user).id
        get :new, user: :user
        expect(assigns(:recipe)).to be_instance_of(Recipe)
      end
    end

    context 'with unauthenticated user' do
      it 'redirects to sign in path' do
        get :new
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'POST create' do
    context 'with authenticated user' do
      let(:current_user) {Fabricate(:user)}
      before {session[:user_id] = current_user.id}
      context 'with valid input' do
        before do
          post :create, recipe: Fabricate.attributes_for(:recipe), user: current_user
        end
        it 'creates the @recipe' do          
          expect(Recipe.count).to eq(1)
        end

        it 'redirects the @recipe page' do
          expect(response).to redirect_to(assigns(:recipe))
        end

        it 'sets the notice' do
          expect(flash[:notice]).not_to be_blank
        end
      end

      context 'with invalid input' do
        before do
          post :create, recipe: Fabricate.attributes_for(:recipe, protocol: nil), user: current_user
        end

        it 'does not create the @recipe' do
          expect(Recipe.count).to eq(0)
        end

        it 'render the :new' do
          expect(response).to render_template :new
        end
      end
    end

    context 'with unauthenticated user' do
      it 'redirects to sign in path' do
        post :create, recipe: Fabricate.attributes_for(:recipe)
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'GET show' do
    let(:recipe) {Fabricate(:recipe)}
    before {session[:user_id] = Fabricate(:user) }
    it 'finds the @recipe for authenticated user' do
      get :show, id: recipe.id
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe 'GET edit' do
    context 'current user equals the @recipe.creator' do
      let(:alice) {Fabricate(:user)}
      let(:recipe) {Fabricate(:recipe, creator: alice)}
      before do
        session[:user_id] = alice.id
        get :edit, id: recipe.id, user: alice
      end
      it 'finds the @recipe' do
        expect(assigns(:recipe)).to eq(recipe) 
      end

      it 'renders the :edit' do
        expect(response).to render_template :edit
      end
    end

    context 'current user not equals the @recipe.user' do
      let(:alice) {Fabricate(:user)}
      let(:bob) {Fabricate(:user)}
      let(:recipe) {Fabricate(:recipe, creator: bob)}
      before do
        session[:user_id] = alice.id
        get :edit, id: recipe.id, user: alice
      end
      it 'redirects to the root page' do
        expect(response).to redirect_to root_path
      end

      it 'sets the error notice' do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe 'POST update' do
    context 'with valid input' do
      let(:alice) {Fabricate(:user)}
      let(:recipe1) {Fabricate(:recipe, creator: alice)}
      before do
        session[:user_id] = alice.id
        post :update, id: recipe1.id, user: alice, recipe: Fabricate.attributes_for(
          :recipe,
          dishname: 'chicken leg')
      end
      it 'updates the @recipe' do
        expect(assigns(:recipe).reload.dishname).to eq('chicken leg')
      end

      it 'redirects to the @recipe' do
        expect(response).to redirect_to(assigns(:recipe))
      end

      it 'sets the notice' do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context 'with invalid input' do
      let(:alice) {Fabricate(:user)}
      let(:recipe1) {Fabricate(:recipe, creator: alice, dishname: "chicken leg")}
      before do
        session[:user_id] = alice.id
        post :update, id: recipe1.id, user: alice, recipe: Fabricate.attributes_for(
          :recipe,
          dishname: nil)
      end
      it 'does not update the @recipe' do
        expect(assigns(:recipe).reload.dishname).to eq("chicken leg")
      end

      it 'renders :edit' do
        expect(response).to render_template :edit
      end
    end
  end
end