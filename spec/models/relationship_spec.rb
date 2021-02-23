require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:relationship) { create(:relationship) }

  it "relationshipインスタンスが有効であること" do
    expect(relationship).to be_valid
  end

  it "follower_idがnilの場合、無効である" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "followed_idがnilの場合、無効である" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end
end
