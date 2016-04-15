require 'spec_helper'

describe PostsController do
  describe 'GET index' do
    it 'sets @posts' do
      post1 = Fabricate(:post)
      post2 = Fabricate(:post)
      get :index
      expect(assigns(:posts)).to match_array([post1, post2])
    end
    it 'sets @categories' do
      category1 = Fabricate(:category)
      category2 = Fabricate(:category)
      get :index
      expect(assigns(:categories)).to match_array([category1, category2])
    end
  end
  describe 'GET new' do
    context 'with authenticated user' do
      it 'sets @post' do
        session[:user_id] = Fabricate(:user).id
        get :new, user: :user
        expect(assigns(:post)).to be_instance_of(Post)
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
          post :create, post: Fabricate.attributes_for(:post), user: current_user
        end
        it 'creates the @post' do          
          expect(Post.count).to eq(1)
        end

        it 'redirects the @post page' do
          expect(response).to redirect_to(assigns(:post))
        end

        it 'sets the notice' do
          expect(flash[:notice]).not_to be_blank
        end
      end

      context 'with invalid input' do
        before do
          post :create, post: Fabricate.attributes_for(:post, title: nil), user: current_user
        end

        it 'does not create the @post' do
          expect(Post.count).to eq(0)
        end

        it 'render the :new' do
          expect(response).to render_template :new
        end
      end
    end

    context 'with unauthenticated user' do
      it 'redirects to sign in path' do
        post :create, post: Fabricate.attributes_for(:post)
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'GET show' do
    let(:post) {Fabricate(:post)}
    before {session[:user_id] = Fabricate(:user) }
    it 'finds the @post for authenticated user' do
      get :show, id: post.id
      expect(assigns(:post)).to eq(post)
    end

    it 'sets the @comment new for authenticated user' do
      get :show, id: post.id, user: :user
      expect(assigns(:comment)).to be_instance_of(Comment)
    end

    it 'sets the @comments for authenticated user' do
      comment1 = Fabricate(:comment, post: post)
      comment2 = Fabricate(:comment, post: post)
      get :show, id: post.id
      expect(assigns(:comments)).should match_array([comment1, comment2])
    end
  end

  describe 'GET edit' do
    context 'current user equals the @post.user' do
      let(:alice) {Fabricate(:user)}
      let(:post) {Fabricate(:post, user: alice)}
      before do
        session[:user_id] = alice.id
        get :edit, id: post.id, user: alice
      end
      it 'finds the @post' do
        expect(assigns(:post)).to eq(post) 
      end
      it 'renders the :edit' do
        expect(response).to render_template :edit
      end
    end
    context 'current user not equals the @post.user' do
      let(:alice) {Fabricate(:user)}
      let(:bob) {Fabricate(:user)}
      let(:post) {Fabricate(:post, user: bob)}
      before do
        session[:user_id] = alice.id
        get :edit, id: post.id, user: alice
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
      let(:post1) {Fabricate(:post, user: alice)}
      before do
        session[:user_id] = alice.id
        post :update, id: post1.id, user: alice, post: Fabricate.attributes_for(
          :post,
          title: 'myfitness')
      end
      it 'updates the @post' do
        expect(assigns(:post).reload.title).to eq('myfitness')
      end

      it 'redirects to the @post' do
        expect(response).to redirect_to(assigns(:post))
      end

      it 'sets the notice' do
        expect(flash[:notice]).not_to be_blank
      end
    end
    context 'with invalid input' do
      let(:alice) {Fabricate(:user)}
      let(:post1) {Fabricate(:post, user: alice, title: "myfitness")}
      before do
        session[:user_id] = alice.id
        post :update, id: post1.id, user: alice, post: Fabricate.attributes_for(
          :post,
          title: nil)
      end
      it 'does not update the @post' do
        expect(assigns(:post).reload.title).to eq("myfitness")
      end

      it 'renders :edit' do
        expect(response).to render_template :edit
      end
    end
  end
end