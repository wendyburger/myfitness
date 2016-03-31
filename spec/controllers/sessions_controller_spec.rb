require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it "renders the new template with unauthenticated user" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to the home page with authenticated user" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do
    context 'with valid credentials' do
      let(:alice) { Fabricate(:user) }
      before do
        post :create, email: alice.email, password: alice.password
      end
      it 'put the signed in user to the session' do
        expect(session[:user_id]).to eq(alice.id)
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to home_path
      end

      it 'sets the notice' do
        expect(flash[:notice]).not_to be_blank
      end
    end
    context 'with invalid credentials' do
      let(:alice) { Fabricate(:user) } 
      before do
        post :create, email: alice.email, password: alice.password + "aassddd"
      end
      it 'does not pust the signed in user in the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'redirect_to the signin template' do
        expect(response).to redirect_to sign_in_path
      end

      it 'sets the error notice' do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      session[:user_id] = Fabricate(:user).id
      delete :destroy
    end
    it 'clears the session for user' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the home page' do
      expect(response[:user_id]).to redirect_to home_path
    end
    
    it 'sets notice' do
      expect(flash[:notice]).not_to be_nil
    end
  end
end