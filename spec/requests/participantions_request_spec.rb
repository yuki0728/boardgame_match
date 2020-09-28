require 'rails_helper'

RSpec.describe "Participantion", type: :request do
  let!(:user) { create(:user) }
  let!(:event) { create(:event, user_id: user.id) }

  describe 'POST #create' do
    before do
      sign_in user
      @participation = attributes_for(:participation, event_id: event.id, user_id: user.id)
    end

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post event_participations_url(event.id), params: { participation: @participation }
        expect(response.status).to eq 302
      end

      it 'イベントが登録されること' do
        expect do
          post event_participations_url(event.id), params: { participation: @participation }
        end.to change(Participation, :count).by(1)
      end

      it 'イベント詳細ページにリダイレクトすること' do
        post event_participations_url(event.id), params: { participation: @participation }
        expect(response).to redirect_to event_url(event.id)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in user
      @participation = create(:participation, event_id: event.id, user_id: user.id)
    end

    it 'リクエストが成功すること' do
      delete event_participation_path(id: @participation.id, event_id: @participation.event_id)
      expect(response.status).to eq 302
    end

    it 'イベントが削除されること' do
      expect do
        delete event_participation_path(id: @participation.id, event_id: @participation.event_id)
      end.to change(Participation, :count).by(-1)
    end

    it 'イベントページにリダイレクトすること' do
      delete event_participation_path(id: @participation.id, event_id: @participation.event_id)
      expect(response).to redirect_to event_url(event.id)
    end
  end
end
