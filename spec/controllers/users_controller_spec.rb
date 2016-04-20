require 'spec_helper'

RSpec.describe UsersController do
  describe 'GET new' do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      
      it 'creates the user' do
        expect(User.count).to eq(1)
      end

      it 'redirects to home page' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid input' do
      before do
        post :create, user: {password: "password", full_name: "Alice Yang"}
      end
      it 'does not create user' do 
        expect(User.count).to eq(0)
      end
      it 'renders the :new template' do
        expect(response).to render_template :new
      end
      it 'sets @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe 'GET edit' do
    context 'current user equals the @user' do
      let(:alice){Fabricate(:user)}
        before do
          session[:user_id] = alice.id
          get :edit, id: alice.id
        end

      it 'finds the @user' do
        expect(assigns(:user)).to eq(alice)
      end 

      it 'renders the edit template' do
        expect(response).to render_template :edit
      end
    end

    context 'current user not equals the @user' do
      before do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        session[:user_id] = alice.id
        get :edit, id: bob.id
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'set the error notice' do
        expect(flash[:notice]).not_to be_blank
      end
    end
  end

  describe 'POST update' do
    context 'with valid input' do
      let(:alice) {Fabricate(:user)}
      before do
        session[:user_id] = alice.id
        post :update, id: alice.id, 
          user: Fabricate.attributes_for(:user, 
            password: 'password', full_name: 'Alice Yang')  
      end

      it 'update the @user' do       
        expect(assigns(:user).reload.full_name).to eq('Alice Yang')
      end

      it 'redirects to root path'do        
        expect(response).to redirect_to root_path
      end

      it 'set the notice' do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context 'with invalid input' do
      let(:alice) {Fabricate(:user, full_name:'Alice Hsu')}
      before do
        session[:user_id] = alice.id
        post :update, id: alice.id, 
          user: Fabricate.attributes_for(:user, 
              password: 'password', full_name: nil)
      end

      it 'does not update the user' do   
        expect(assigns(:user).reload.full_name).to eq('Alice Hsu')
      end
      
      it 'renders the :edit' do       
        expect(response).to render_template :edit
      end
    end
  end

  describe 'GET show' do
    let(:user) {Fabricate(:user)}
    before do
      session[:user_id] = user.id
      get :show, id: user.id
    end
    it 'finds the @user' do
      expect(assigns(:user)).to eq(user)
    end
  end
end