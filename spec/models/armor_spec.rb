require 'rails_helper'

RSpec.describe Armor, type: :model do
  describe 'head_armor' do
    it 'nameが入力されていれば有効であること' do
      head_armor = build(:head_armor)
      expect(head_armor).to be_valid
    end
  end

  describe 'body_armor' do
    it 'nameが入力されていれば有効であること' do
      body_armor = build(:body_armor)
      expect(body_armor).to be_valid
    end
  end

  describe 'arm_armor' do
    it 'nameが入力されていれば有効であること' do
      arm_armor = build(:arm_armor)
      expect(arm_armor).to be_valid
    end
  end

  describe 'waist_armor' do
    it 'nameが入力されていれば有効であること' do
      waist_armor = build(:waist_armor)
      expect(waist_armor).to be_valid
    end
  end

  describe 'foot_armor' do
    it 'nameが入力されていれば有効であること' do
      foot_armor = build(:foot_armor)
      expect(foot_armor).to be_valid
    end
  end
end
