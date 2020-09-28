require 'rails_helper'

RSpec.describe "Participations", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  scenario "ユーザがイベントに参加できる" do
    login_as(user, :scope => :user)
    event = create(:event, user_id: other_user.id)
    visit root_path
    expect do
      click_on event.name
      click_on "イベント参加"
      expect(current_path).to eq event_path(event.id)
    end.to change(Participation, :count).by(1)
  end

  scenario "ユーザがイベントの参加を取り消しできる" do
    login_as(user, :scope => :user)
    event = create(:event, user_id: other_user.id)
    create(:participation, event_id: event.id, user_id: user.id)
    visit root_path
    expect do
      click_on event.name
      click_on "イベント参加取り消し"
      expect(current_path).to eq event_path(event.id)
    end.to change(Participation, :count).by(-1)
  end
end
