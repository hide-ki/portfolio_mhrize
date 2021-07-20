require 'rails_helper'

RSpec.describe Post, type: :model do
  before { create(:user) }
  it 'imageに画像が選択されていれば有効であること' do
    post = build(:post)
    expect(post).to be_valid
  end
end
