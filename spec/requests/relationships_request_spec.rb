require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:event) { create(:event, user: user) }

  describe 'POST #create' do
    context "ログインしているユーザーの場合" do
      before do
        sign_in user
      end

      it 'リクエストが成功すること' do
        post relationships_path, params: { followed_id: other_user.id }
        expect(response.status).to eq 302
      end

      it 'userがother_userをフォローすること' do
        expect do
          post relationships_path, params: { followed_id: other_user.id }
        end.to change(Relationship, :count).by(1)
      end

      it 'ユーザページにリダイレクトすること' do
        post relationships_path, params: { followed_id: other_user.id }
        expect(response).to redirect_to user_path(other_user.id)
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログインページへリダイレクトすること" do
        post relationships_path, params: { followed_id: other_user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #destroy' do
    let!(:relationship) { create(:relationship, followed_id: other_user.id, follower_id: user.id) }

    context "ログインしているユーザーの場合" do
      before do
        sign_in user
      end

      it 'リクエストが成功すること' do
        delete relationship_path(relationship.id)
        expect(response.status).to eq 302
      end

      it 'userがother_userをフォロー解除すること' do
        expect do
          delete relationship_path(relationship.id)
        end.to change(Relationship, :count).by(-1)
      end

      it 'ユーザページにリダイレクトすること' do
        delete relationship_path(relationship.id)
        expect(response).to redirect_to user_path(other_user.id)
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログインページへリダイレクトすること" do
        delete relationship_path(relationship.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
