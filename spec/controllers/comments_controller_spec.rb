require 'spec_helper'

describe CommentsController do
  describe 'POST create' do
    context 'with valid input' do  
      let(:current_user) {Fabricate(:user)}
      let(:post1) {Fabricate(:post)}
      before do 
        session[:user_id] = current_user.id
        post :create, comment: Fabricate.attributes_for(:comment), post_id: post1.id
      end
      it 'create the @comment' do
        expect(Comment.count).to eq(1)

      end
      it 'set the notice' do
        expect(flash[:notice]).not_to be_blank
      end

      it 'redirect to the @post' do
        expect(response).to redirect_to post_path(post1)
      end
    end

    context 'with invalid input' do
      let(:current_user) {Fabricate(:user)}
      let(:post1) {Fabricate(:post)}
      before do
        session[:user_id] = current_user.id
        post :create, comment: Fabricate.attributes_for(:comment, body: nil), post_id: post1.id
      end
      it 'does not create the @comment' do
        expect(Comment.count).to eq(0)
      end

      it 'render post/show' do
        expect(response).to render_template 'posts/show'
      end
    end
  end
end