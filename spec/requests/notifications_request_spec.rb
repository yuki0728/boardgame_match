require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:event) { create(:event, user: user) }

  describe 'GET #index' do
    context "ログインしているユーザーの場合" do
      before do
        sign_in user
      end

      it 'リクエストが成功すること' do
        get notifications_path
        expect(response.status).to eq 200
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログインページへリダイレクトすること" do
        get notifications_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #deatroy_all' do
    let!(:notification) { create(:notification, visiter_id: other_user.id, visited_id: user.id) }

    context "ログインしているユーザーの場合" do
      before do
        sign_in user
      end

      it 'リクエストが成功すること' do
        delete destroy_all_notifications_path
        expect(response.status).to eq 302
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログインページへリダイレクトすること" do
        delete destroy_all_notifications_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
