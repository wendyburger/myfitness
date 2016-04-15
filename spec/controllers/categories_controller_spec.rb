require 'spec_helper'

describe CategoriesController do
  describe 'GET new' do
    context 'with admin' do
      it 'sets @category for admin' do
        session[:user_id] = Fabricate(:user, role: 'admin').id
        get :new, user: :user
        expect(assigns(:category)).to be_instance_of(Category)
      end
    end

    context 'not the admin' do
      before do
        session[:user_id] = Fabricate(:user, role: nil).id
        get :new, user: :user       
      end
      it 'redirects to the home page for the user who is not the admin' do
        expect(response).to redirect_to root_path
      end

      it 'set the error notice' do
        expect(flash[:error]).not_to be_blank 
      end
    end
  end

  describe 'POST create' do
    let(:alice) {Fabricate(:user, role: 'admin')}
    before do
      session[:user_id] = alice.id
      post :create, category: Fabricate.attributes_for(:category)      
    end
    it 'creates the @category' do
      expect(Category.count).to eq(1)
    end

    it 'redirects to home page' do
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET show' do
    it 'finds the @category' do
      category = Fabricate(:category)
      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end
end