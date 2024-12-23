require 'rails_helper'

RSpec.describe "PostDetails", type: :system do
  describe '行き先追加', js: true do
    let(:image_path) { Rails.root.join('app/assets/images/DayOutLog.png') }
    let(:post_detail_image_path) { Rails.root.join('app/assets/images/girl.png') }

    before do
      user = FactoryBot.create(:user)
      login_as(user)
      sleep 3
      visit new_post_path
      fill_in 'タイトル [必須]', with: 'title'
      fill_in '出発日 [必須]', with: '002024-12-01'
      attach_file('サムネイル', image_path, make_visible: true)
      click_button '行き先を追加'
      sleep 5
      latest_post = Post.order(created_at: :desc).first
      expect(page).to have_current_path(new_post_post_detail_path(latest_post))
    end

    context 'フォームの入力値が正常' do
      it '行き先の追加が成功する' do
        fill_in '本文 [必須]', with: 'テストテストテスト'
        fill_in '到着時間 [必須]', with: '12:00'
        attach_file('画像', post_detail_image_path, make_visible: true)
        fill_in '住所', with: '東京駅'
        sleep 1
        expect(page).to have_selector('.pac-item', visible: true)
        find('.pac-item', match: :first).click
        click_on '追加'
        expect(page).to have_content('テストテストテスト')
        expect(page).to have_content('12:00')
        expect(page).to have_content('東京駅')
        expect(page).to have_css("img[src*='girl.png']")
      end

      it '行き先の追加後、投稿が成功する' do
        fill_in '本文 [必須]', with: 'テストテストテスト'
        fill_in '到着時間 [必須]', with: '12:00'
        attach_file('画像', post_detail_image_path, make_visible: true)
        fill_in '住所', with: '東京駅'
        sleep 1
        expect(page).to have_selector('.pac-item', visible: true)
        find('.pac-item', match: :first).click
        click_on '追加'
        sleep 5
        click_on '記事を投稿する'
        page.accept_alert '記事を投稿します。よろしいですか？'
        sleep 5
        latest_post = Post.order(created_at: :desc).first
        expect(page).to have_current_path(post_path(latest_post))
        expect(page).to have_content('title')
        expect(page).to have_content('2024/12/01')
        expect(page).to have_css("img[src*='DayOutLog.png']")
        expect(page).to have_content('テストテストテスト')
        expect(page).to have_content('12:00')
        expect(page).to have_content('東京駅')
        expect(page).to have_css("img[src*='girl.png']")
      end
    end

    context '本文' do
      it '本文が未入力の場合、行き先の追加が失敗する' do
        fill_in '到着時間 [必須]', with: '12:00'
        attach_file('画像', post_detail_image_path, make_visible: true)
        fill_in '住所', with: '東京駅'
        sleep 1
        expect(page).to have_selector('.pac-item', visible: true)
        find('.pac-item', match: :first).click
        click_on '追加'
        expect(page).to have_content('本文を入力してください')
      end
    end

    context '到着時間' do
      it '到着時間が未入力の場合、行き先の追加が失敗する' do
        fill_in '本文 [必須]', with: 'テストテストテスト'
        attach_file('画像', post_detail_image_path, make_visible: true)
        fill_in '住所', with: '東京駅'
        sleep 1
        expect(page).to have_selector('.pac-item', visible: true)
        find('.pac-item', match: :first).click
        click_on '追加'
        expect(page).to have_content('到着時間を入力してください')
      end
    end
  end

  describe '行き先削除', js: true do
    let(:image_path) { Rails.root.join('app/assets/images/DayOutLog.png') }
    let(:post_detail_image_path) { Rails.root.join('app/assets/images/girl.png') }

    before do
      user = FactoryBot.create(:user)
      login_as(user)
      sleep 3
      visit new_post_path
      fill_in 'タイトル [必須]', with: 'title'
      fill_in '出発日 [必須]', with: '002024-12-01'
      attach_file('サムネイル', image_path, make_visible: true)
      click_button '行き先を追加'
      sleep 5
      latest_post = Post.order(created_at: :desc).first
      expect(page).to have_current_path(new_post_post_detail_path(latest_post))
    end

    it '行き先の削除が成功する' do
      fill_in '本文 [必須]', with: 'テストテストテスト'
      fill_in '到着時間 [必須]', with: '12:00'
      attach_file('画像', post_detail_image_path, make_visible: true)
      fill_in '住所', with: '東京駅'
      sleep 1
      expect(page).to have_selector('.pac-item', visible: true)
      find('.pac-item', match: :first).click
      click_on '追加'
      expect(page).to have_content('テストテストテスト')
      expect(page).to have_content('12:00')
      expect(page).to have_content('東京駅')
      expect(page).to have_css("img[src*='girl.png']")
      click_on '削除'
      page.accept_alert '行き先を削除します。よろしいですか？'
      expect(page).to have_content('まだ行き先が追加されていません')
    end
  end
end
