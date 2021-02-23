require 'rails_helper'

RSpec.describe "Events", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  scenario "ユーザがイベントを作成できる" do
    login_as(user, :scope => :user)
    event = attributes_for(:event)
    visit root_path
    expect do
      find("#create_event_btn").click
      fill_in I18n.t(:"activerecord.attributes.event.name"), with: event[:name]
      fill_in I18n.t(:"activerecord.attributes.event.text"), with: event[:text]
      fill_in I18n.t(:"activerecord.attributes.event.start_time"), with: event[:start_time]
      fill_in I18n.t(:"activerecord.attributes.event.ending_time"), with: event[:ending_time]
      fill_in I18n.t(:"activerecord.attributes.event.participant_limit"), with: event[:participant_limit]
      fill_in I18n.t(:"activerecord.attributes.event.tag_list"), with: event[:tag_list]
      click_on I18n.t(:"helpers.submit.create")
      expect(page).to have_content event[:name]
      expect(page).to have_content event[:text]
    end.to change(Event, :count).by(1)
  end

  scenario "主催者のみはイベントを削除できる" do
    login_as(user, :scope => :user)
    event = create(:event, user_id: user.id)
    visit root_path
    expect do
      click_on event.name
      click_on "イベント削除"
      expect(current_path).to eq root_path
    end.to change(Event, :count).by(-1)
  end

  scenario "主催者はイベントを編集できる" do
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
    end.to change(Event, :count).by(0)
  end

  scenario "主催者以外はイベント削除、編集が表示さない" do
    event = create(:event, user_id: user.id)
    login_as(other_user, :scope => :user)
    visit root_path
    click_on event.name
    expect(page).not_to have_content "イベント編集"
    expect(page).not_to have_content "イベント編集"
  end
end
