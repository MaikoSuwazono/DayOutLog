require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe '新規投稿作成' do
    before do
      user = FactoryBot.create(:user)
      login_as(user)
      sleep 3
    end
      
    let(:image_path) { Rails.root.join('app/assets/images/DayOutLog.png') }

    context 'フォームの入力値が正常' do
      it '新規投稿作成が成功する' do
        visit new_post_path
  
        fill_in 'タイトル [必須]', with: 'title'
        fill_in '出発日 [必須]', with: '002024-12-01'
        attach_file('サムネイル', image_path, make_visible: true)
        click_button '行き先を追加'
      
        sleep 5
        latest_post = Post.order(created_at: :desc).first
        expect(page).to have_current_path(new_post_post_detail_path(latest_post))
        expect(page).to have_content('title')
        expect(page).to have_content('2024/12/01')
        expect(page).to have_css("img[src*='DayOutLog.png']")
      end
    end

    context 'タイトル' do
      it 'タイトルが未入力の場合、新規投稿作成が失敗する' do
        visit new_post_path
    
        fill_in 'タイトル [必須]', with: ''
        fill_in '出発日 [必須]', with: '002024-12-01'
        attach_file('サムネイル', image_path, make_visible: true)
        click_button '行き先を追加'

        sleep 5
        expect(page).to have_current_path(new_post_path)
        expect(page).to have_content('記事の作成に失敗しました')
        expect(page).to have_content('タイトルを入力してください')
      end
    end

    context '出発日' do
      it '出発日が未入力の場合、新規投稿作成が失敗する' do
        visit new_post_path
    
        fill_in 'タイトル [必須]', with: 'title'
        fill_in '出発日 [必須]', with: ''
        attach_file('サムネイル', image_path, make_visible: true)
        click_button '行き先を追加'

        sleep 5
        expect(page).to have_current_path(new_post_path)
        expect(page).to have_content('記事の作成に失敗しました')
        expect(page).to have_content('出発日を入力してください')
      end

      it '出発日が未来の場合、新規投稿作成が失敗する' do
        visit new_post_path
    
        fill_in 'タイトル [必須]', with: 'title'
        fill_in '出発日 [必須]', with: Date.tomorrow
        attach_file('サムネイル', image_path, make_visible: true)
        click_button '行き先を追加'

        sleep 5
        expect(page).to have_current_path(new_post_path)
        expect(page).to have_content('記事の作成に失敗しました')
        expect(page).to have_content('出発日は今日より前の日付を入力してください')
      end

      it '出発日が今日の場合、新規投稿作成が成功する' do
        visit new_post_path
    
        fill_in 'タイトル [必須]', with: 'title'
        fill_in '出発日 [必須]', with: Date.today
        attach_file('サムネイル', image_path, make_visible: true)
        click_button '行き先を追加'

        sleep 5
        latest_post = Post.order(created_at: :desc).first
        expect(page).to have_current_path(new_post_post_detail_path(latest_post))
        expect(page).to have_content('title')
        expect(page).to have_content(Date.today.strftime('%Y/%m/%d'))
        expect(page).to have_css("img[src*='DayOutLog.png']")
      end

      it '出発日が過去の場合、新規投稿作成が成功する' do
        visit new_post_path
    
        fill_in 'タイトル [必須]', with: 'title'
        fill_in '出発日 [必須]', with: Date.yesterday
        attach_file('サムネイル', image_path, make_visible: true)
        click_button '行き先を追加'

        sleep 5
        latest_post = Post.order(created_at: :desc).first
        expect(page).to have_current_path(new_post_post_detail_path(latest_post))
        expect(page).to have_content('title')
        expect(page).to have_content(Date.yesterday.strftime('%Y/%m/%d'))
        expect(page).to have_css("img[src*='DayOutLog.png']")
      end
    end
  end

  describe '投稿削除' do
    let(:post) { FactoryBot.create(:post) }
    let(:otheruser_post) { FactoryBot.create(:post) }
    
    it 'ログインユーザーの投稿の場合、投稿の削除に成功する' do
      login_as(post.user)
      sleep 5
      visit post_path(post)
      click_on '削除'
      page.accept_alert '記事を削除します。よろしいですか？'
      expect(page).to have_current_path(posts_path)
      expect(page).to have_content('記事が削除されました')
      expect(Post.count).to eq(0)
    end

    it '他ユーザーの投稿の場合、投稿の削除ができない' do
      login_as(post.user)
      sleep 5
      visit post_path(otheruser_post)
      expect(page).not_to have_button('削除')
    end
  end
end
