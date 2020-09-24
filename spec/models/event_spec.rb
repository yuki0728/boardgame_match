require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'バリテーションを通過していること' do
    event = build(:event)
    expect(event).to be_valid
  end

  it "イベント名がなければ無効である" do
    event = build(:event, name: nil)
    expect(event).to be_invalid
  end

  it "イベント名が101文字以上なら無効である" do
    event = build(:event, name: "a" * 101)
    expect(event).to be_invalid
  end

  it "本文がなければ無効である" do
    event = build(:event, text: nil)
    expect(event).to be_invalid
  end

  it "本文が3001文字以上なら無効である" do
    event = build(:event, text: "a" * 3001)
    expect(event).to be_invalid
  end

  it "開始時間が終了時間より前なら無効である" do
    event = build(:event,
                  start_time: DateTime.current.since(2.seconds),
                  ending_time: DateTime.current.since(1.seconds))
    expect(event).to be_invalid
  end

  it "開始時間が現在より前であるなら無効である" do
    event = build(:event, start_time: DateTime.current.ago(1.seconds))
    expect(event).to be_invalid
  end

  it "参加上限が数字意外であれば無効である" do
    event = build(:event, participant_limit: 'a')
    expect(event).to be_invalid
  end

  it "参加上限が0以下であれば無効である" do
    event = build(:event, participant_limit: 0)
    expect(event).to be_invalid
  end
end
