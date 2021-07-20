require 'rails_helper'

RSpec.describe FirstColor, type: :model do
  let(:post) { create(:post) }

  it 'hue,saturation,valueを正常に入力すれば有効であること' do
    first_color = build(:first_color)
    expect(first_color).to be_valid
  end

  it '色相hueが360より大きいなら無効であること' do
    first_color = build(:first_color, post: post, hue: '361')
    first_color.valid?
    expect(first_color.errors[:hue]).to include('は360以下の値にしてください')
  end

  it '彩度saturationが100より大きいなら無効であること' do
    first_color = build(:first_color, post: post, saturation: '101')
    first_color.valid?
    expect(first_color.errors[:saturation]).to include('は100以下の値にしてください')
  end

  it '明度valueが100より大きいなら無効であること' do
    first_color = build(:first_color, post: post, value: '101')
    first_color.valid?
    expect(first_color.errors[:value]).to include('は100以下の値にしてください')
  end
end
