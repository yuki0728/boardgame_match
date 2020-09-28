require 'rails_helper'

shared_context 'login_user' do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end
end

shared_examples 'Check_redirect_to_sign_in_page' do
  it 'サインインページにリダイレクトされること' do
    expect(response).to redirect_to new_user_session_path
  end
end

shared_examples 'Check_request_success' do
  it 'リクエストが成功すること' do
    expect(response.status).to eq 200
  end
end

RSpec.describe "Events", type: :request do
  describe 'GET #index' do
    let!(:events) { create_list :event, 3 }

    before { get events_url }

    it_behaves_like 'Check_request_success'

    it 'イベント名及び本文が表示されていること' do
      aggregate_failures do
        0.upto(2).each do |index|
          expect(response.body).to include events[index].name
          expect(response.body).to include events[index].text
        end
      end
    end
  end

  describe 'GET #show' do
    context 'ログインしている場合' do
      include_context 'login_user'

      context 'イベントが存在する場合' do
        let!(:event) { create(:event) }

        before { get event_url(event.id) }

        it_behaves_like 'Check_request_success'

        it 'イベント名及び本文が表示されていること' do
          expect(response.body).to include event.name
          expect(response.body).to include event.text
        end
      end

      context 'イベントが存在しない場合' do
        it 'リクエストが失敗すること' do
          expect { get event_url(1) }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    context 'ログインしていない場合' do
      let!(:event) { create(:event) }

      before do
        get event_url(event.id)
      end

      it_behaves_like 'Check_redirect_to_sign_in_page'
    end
  end

  describe 'GET #new' do
    context 'ログインしている場合' do
      include_context 'login_user'

      before { get new_event_url }

      it_behaves_like 'Check_request_success'
    end

    context 'ログインしていない場合' do
      before { get new_event_url }

      it_behaves_like 'Check_redirect_to_sign_in_page'
    end
  end

  describe 'GET #edit' do
    context 'ログインしている場合' do
      include_context 'login_user'

      context 'イベントが存在する場合' do
        let!(:event) { create(:event) }

        before { get edit_event_url(event.id) }

        it_behaves_like 'Check_request_success'

        it 'イベントの各項目が表示されていること' do
          aggregate_failures do
            expect(response.body).to include event.name
            expect(response.body).to include event.text
          end
        end
      end

      context 'イベントが存在しない場合' do
        it 'リクエストが失敗すること' do
          expect { get edit_event_url(1) }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    context 'ログインしていない場合' do
      let!(:event) { create(:event) }

      before { get edit_event_url(event.id) }

      it_behaves_like 'Check_redirect_to_sign_in_page'
    end
  end

  describe 'POST #create' do
    include_context 'login_user'

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post events_url, params: { event: attributes_for(:event) }
        expect(response.status).to eq 302
      end

      it 'イベントが登録されること' do
        expect do
          post events_url, params: { event: attributes_for(:event) }
        end.to change(Event, :count).by(1)
      end

      it 'リダイレクトすること' do
        post events_url, params: { event: attributes_for(:event) }
        expect(response).to redirect_to Event.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post events_url, params: { event: attributes_for(:event, :invalid) }
        expect(response.status).to eq 200
      end

      it 'イベントが登録されないこと' do
        expect do
          post events_url, params: { event: attributes_for(:event, :invalid) }
        end.not_to change(Event, :count)
      end

      it 'エラーが表示されること' do
        post events_url, params: { event: attributes_for(:event, :invalid) }
        expect(response.body).to include 'イベント名を入力してください'
      end
    end
  end

  describe 'PUT #update' do
    let(:event) { create :event }

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put event_url event, params: { event: attributes_for(:event, :update_event) }
        expect(response.status).to eq 302
      end

      it 'イベント名が更新されること' do
        update_event = attributes_for(:event, :update_event)
        expect do
          put event_url event, params: { event: update_event }
        end.to change { Event.find(event.id).name }.from(event.name).to(update_event[:name])
      end

      it 'リダイレクトすること' do
        put event_url event, params: { event: attributes_for(:event, :update_event) }
        expect(response).to redirect_to Event.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put event_url event, params: { event: attributes_for(:event, :invalid) }
        expect(response.status).to eq 200
      end

      it 'イベント名が変更されないこと' do
        expect do
          put event_url event, params: { event: attributes_for(:event, :invalid) }
        end.not_to change(Event.find(event.id), :name)
      end

      it 'エラーが表示されること' do
        put event_url event, params: { event: attributes_for(:event, :invalid) }
        expect(response.body).to include I18n.t(:"errors.messages.empty")
      end
    end
  end

  describe 'DELETE #destroy' do
    include_context 'login_user'
    let!(:event) { create :event, user_id: user.id }

    it 'リクエストが成功すること' do
      delete event_url event
      expect(response.status).to eq 302
    end

    it 'イベントが削除されること' do
      expect do
        delete event_url event
      end.to change(Event, :count).by(-1)
    end

    it 'イベント一覧にリダイレクトすること' do
      delete event_url event
      expect(response).to redirect_to(events_url)
    end
  end
end
