require 'rails_helper'

RSpec.describe SecondColor, type: :model do
  let(:post) { create(:post) }

  it 'hue,saturation,valueを正常に入力すれば有効であること' do
    second_color = build(:second_color)
    expect(second_color).to be_valid
  end

  it '色相hueが360より大きいなら無効であること' do
    second_color = build(:second_color, post: post, hue: '361')
    second_color.valid?
    expect(second_color.errors[:hue]).to include('は360以下の値にしてください')
  end

  it '彩度saturationが100より大きいなら無効であること' do
    second_color = build(:second_color, post: post, saturation: '101')
    second_color.valid?
    expect(second_color.errors[:saturation]).to include('は100以下の値にしてください')
  end

  it '明度valueが100より大きいなら無効であること' do
    second_color = build(:second_color, post: post, value: '101')
    second_color.valid?
    expect(second_color.errors[:value]).to include('は100以下の値にしてください')
  end
end
