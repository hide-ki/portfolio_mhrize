require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'Post作成' do
    context '正常系' do
      it '入力内容が正常なら、postが作成できること' do
        login_as(user)
        click_link '投稿'
        attach_file 'post[image]', "#{Rails.root}/spec/fixtures/peach-1.jpg"
        click_button '投稿'
        expect(page).to have_content '投稿が作成されました。'
        expect(current_path).to eq root_path
        # 画像にalt属性またはidをつけたら画像が表示されていることを確認する
        expect(page).to have_selector("img[src$='peach-1.jpg']")
      end
    end
    context '異常系' do
      it '入力内容が正しくない場合、postが作成されないこと' do
        login_as(user)
        click_link '投稿'
        click_button '投稿'
        expect(page).to have_content '投稿に失敗しました。'
        expect(page).to have_content '重ね着画像を入力してください'
      end
    end
  end

  describe 'Post詳細' do
    context '正常系' do
      it 'postの詳細を表示できること' do
        login_as(user)
        post
        visit root_path
        # imageにclassを指定しているので、classを見つけてクリックさせている
        find('.post_image').click
        expect(page).to have_content '装備詳細'
        expect(current_path).to eq post_path(post)
      end
      it 'postを正常に編集できること' do
        login_as(user)
        post
        visit edit_post_path(post)
        fill_in 'タイトル', with: 'hoge'
        click_button '更新'
        expect(page).to have_content '編集しました。'
        expect(current_path).to eq post_path(post)
      end
    end
  end
  describe 'Post編集' do
    context 'postのユーザーが同一な場合' do
      it '編集ページにアクセスできること' do
        login_as(user)
        post
        visit root_path
        find('.post_image').click
        click_link '編集'
        expect(page).to have_content '装備編集'
        expect(current_path).to eq edit_post_path(post)
      end
    end

    context 'postのユーザーが別のユーザーの場合' do
      it '編集ページではなくroot_pathに遷移すること' do
        user
        post
        login_as(other_user)
        visit root_path
        find('.post_image').click
        visit edit_post_path(post)
        expect(current_path).to eq root_path
      end
    end

    context '画像を変更' do
      it '投稿の編集ができること' do
        user
        post
        login_as(user)
        visit edit_post_path(post)
        attach_file 'post[image]', "#{Rails.root}/spec/fixtures/images.jpeg"
        click_button '更新'
        expect(page).to have_content '編集しました。'
        expect(page).to have_selector("img[src$='images.jpeg']")
        expect(current_path).to eq post_path(post)
      end
    end
  end
  describe 'Post削除' do
    context '確認ダイアログでOKボタンをおす' do
      it 'postを削除できること' do
        login_as(user)
        post
        visit post_path(post)
        click_link '削除'
        expect do
          expect(page.accept_confirm).to eq '投稿を削除してもよろしいですか？'
          expect(page).to have_content '削除しました。'
        end.to change(user.posts, :count).by(-1)
        expect(current_path).to eq root_path
      end
    end
    context '確認ダイアログでキャンセルボタンをおす' do
      it 'postを削除できないこと' do
        login_as(user)
        post
        visit post_path(post)
        click_link '削除'
        expect do
          expect(page.dismiss_confirm).to eq '投稿を削除してもよろしいですか？'
        end.to change(user.posts, :count).by(0)
        expect(current_path).to eq post_path(post)
      end
    end
  end

  describe '検索機能' do
    let(:user) { create(:user) }
    let(:post_with_gentlemen) { create(:post, :gentlemen) }
    let(:post_with_lady) { create(:post, :lady) }
    let(:post) { create(:post) }
    let(:other_post) { create(:post) }
    context 'キャラの性別で検索' do
      it '検索してマッチした投稿が表示されること' do
        post_with_gentlemen
        post_with_lady
        login_as(user)
        select '男', from: 'q[character_gender_eq]'
        click_on '検索'
        expect(page).to have_content post_with_gentlemen.title
        expect(page).not_to have_content post_with_lady.title
      end
      it '検索でマッチしなければ表示されないこと' do
        post
        login_as(user)
        select '女', from: 'q[character_gender_eq]'
        click_on '検索'
        expect(page).not_to have_content post.title
      end
    end
    context 'タイトルで検索' do
      it 'タイトルが一致した投稿だけ表示されること' do
        post
        other_post
        login_as(user)
        fill_in 'q[title_cont]', with: post.title
        click_on '検索'
        expect(page).to have_content post.title
        expect(page).not_to have_content other_post.title
      end
    end
    context '防具で検索' do
      before do
        post
        other_post
        login_as(user)
      end

      it '頭部で検索して一致した投稿だけ表示されること' do
        fill_in 'q[head_armor_name_cont]', with: post.head_armor.name
        click_on '検索'
        expect(page).to have_content post.title
        expect(page).not_to have_content other_post.title
      end
      it '胴部で検索して一致した投稿だけ表示されること' do
        fill_in 'q[body_armor_name_cont]', with: post.body_armor.name
        click_on '検索'
        expect(page).to have_content post.title
        expect(page).not_to have_content other_post.title
      end
      it '腕部で検索して一致した投稿だけ表示されること' do
        fill_in 'q[arm_armor_name_cont]', with: post.arm_armor.name
        click_on '検索'
        expect(page).to have_content post.title
        expect(page).not_to have_content other_post.title
      end
      it '腰部で検索して一致した投稿だけが表示されること' do
        fill_in 'q[waist_armor_name_cont]', with: post.waist_armor.name
        click_on '検索'
        expect(page).to have_content post.title
        expect(page).not_to have_content other_post.title
      end
      it '脚部で検索して一致した投稿だけが表示されること' do
        fill_in 'q[foot_armor_name_cont]', with: post.foot_armor.name
        click_on '検索'
        expect(page).to have_content post.title
        expect(page).not_to have_content other_post.title
      end
    end
  end
  describe 'いいね機能' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    context 'いいねをクリック' do
      it 'いいねできること' do
        login_as(user)
        post
        visit root_path
        find('.far').click
        expect(page).to have_css '.fas'
        expect(page).to have_css '.likes-button', text: '1'
      end
    end
    context 'いいねを削除' do
      it 'いいねを取り消せること' do
        login_as(user)
        post
        visit root_path
        find('.far').click
        find('.fas').click
        expect(page).to have_css '.far'
        expect(page).to have_css '.likes-button', text: '0'
      end
    end
  end
end
