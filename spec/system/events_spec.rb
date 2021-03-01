require 'rails_helper'

RSpec.describe "Events", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  scenario "ユーザがイベントを作成出来ない" do
    login_as(user, :scope => :user)
    visit root_path
    # イベント作成ページに移動する
    find("#create_event_btn").click

    expect do
      # イベント情報を入力する
      event_create_with("", "", "", "", "", "", "")
    end.to change(Event, :count).by(0) # イベント数が一つ増える
  end

  scenario "ユーザがイベントを作成できる" do
    login_as(user, :scope => :user)
    event = attributes_for(:event)
    visit root_path
    # イベント作成ページに移動する
    find("#create_event_btn").click

    expect do
      # イベント情報を入力する
      event_create_with(event[:name], event[:text], event[:start_time],
                        event[:ending_time], event[:participant_limit],
                        event[:tag_list], 'spec/fixtures/event_sample.jpg')

      # イベント詳細ページにリダイレクトする
      expect(current_path).to eq event_path(Event.last.id)

      # 各イベント情報が記入されている
      expect(page).to have_content event[:name]
      expect(page).to have_content event[:text]
      expect(page).to have_content I18n.l(event[:start_time], format: :long, default: '-')
      expect(page).to have_content I18n.l(event[:ending_time], format: :short, default: '-')
      expect(page).to have_content event[:participant_limit]
      expect(page).to have_content event[:tag_list].split(",")[0]
      expect(page).to have_content event[:tag_list].split(",")[1]
    end.to change(Event, :count).by(1) # イベント数が一つ増える
  end

  scenario "主催者のみイベントを削除できる" do
    login_as(user, :scope => :user)
    event = create(:event, user_id: user.id)
    visit root_path
    expect do
      click_on event.name
      click_on "イベント削除"
      expect(current_path).to eq root_path
    end.to change(Event, :count).by(-1) # イベント数が一つ減る
  end

  scenario "主催者のみイベントを編集できる" do
    login_as(user, :scope => :user)
    event = create(:event, user_id: user.id)
    visit root_path
    expect do
      click_on event.name
      click_on "イベント編集"
      fill_in I18n.t(:"activerecord.attributes.event.name"), with: "編集後タイトル"
      click_button I18n.t(:"helpers.submit.update")
      expect(current_path).to eq event_path(event.id)
      expect(page).to have_content "編集後タイトル"
    end.to change(Event, :count).by(0) # イベント数が変わらない
  end

  scenario "主催者以外はイベント削除、編集が表示しない" do
    event = create(:event, user_id: user.id)
    login_as(other_user, :scope => :user)
    visit root_path
    click_on event.name
    expect(page).not_to have_content "イベント編集"
    expect(page).not_to have_content "イベント編集"
  end
end
