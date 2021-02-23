require 'rails_helper'

RSpec.describe Participation, type: :model do
  let!(:user) { create(:user) }
  let!(:other_user) { create_list(:user, 2) }
  let!(:event) { create(:event, user_id: user.id, participant_limit: 2) }

  it 'イベントの参加人数が参加人数上限以下の場合は参加できる' do
    participation = build(:participation, user_id: user.id, event_id: event.id)
    expect(participation).to be_valid
  end

  it 'イベントの参加人数が参加人数上限以上になる場合は参加できない' do
    0.upto(1).each do |index|
      create(:participation, user_id: other_user[index].id, event_id: event.id)
    end
    participation = build(:participation, user_id: user.id, event_id: event.id)
    expect(participation).to be_invalid
  end
end
