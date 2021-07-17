require 'rails_helper'

RSpec.describe 'Mypages', type: :system do
  describe 'マイページの表示' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let(:other_post) { create(:post, :other_image, user: user) }
    context '正常系' do
      it '自分の投稿が表示されること' do
        login_as(user)
        post
        other_post
        visit user_mypages_path(user)
        expect(page).to have_selector("img[src$='images.jpeg']")
        expect(page).to have_selector("img[src$='peach-1.jpg']")
        expect(current_path).to eq user_mypages_path(user)
      end
      it '投稿がなければ表示されないこと' do
        login_as(user)
        visit user_mypages_path(user)
        expect(page).not_to have_selector("img[src$='']")
        expect(current_path).to eq user_mypages_path(user)
      end
    end
  end
end
