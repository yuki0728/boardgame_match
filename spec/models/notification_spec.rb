require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:notification) { create(:notification) }

  it "notificationインスタンスが有効である" do
    expect(notification).to be_valid
  end

  it "visiter_idがnilでも有効である" do
    notification.visiter_id = nil
    expect(notification).to be_valid
  end

  it "visited_idがnilでも有効である" do
    notification.visited_id = nil
    expect(notification).to be_valid
  end

  it "event_idがnilでも有効である" do
    notification.event_id = nil
    expect(notification).to be_valid
  end
end
