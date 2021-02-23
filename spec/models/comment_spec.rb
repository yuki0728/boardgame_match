require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create(:comment) }

  it "commentインスタンスが有効である" do
    expect(comment).to be_valid
  end

  it "user_idがnilでも無効である" do
    comment.user_id = nil
    expect(comment).to be_invalid
  end

  it "event_idがnilでも無効である" do
    comment.event_id = nil
    expect(comment).to be_invalid
  end
end
