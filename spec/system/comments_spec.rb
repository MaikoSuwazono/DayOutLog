require 'rails_helper'

RSpec.describe "Comments", type: :system do
  describe 'コメント作成', js: true do
    let(:post) { FactoryBot.create(:post) }
  
    before do
      user = FactoryBot.create(:user)
      login_as(user)
      sleep 3
    end

    context 'フォームの入力値が正常' do
      it 'コメントの投稿が成功する' do
        visit post_path(post)
        fill_in 'コメント', with: 'コメントコメントコメント'
        click_on '投稿'
        expect(page).to have_current_path(post_path(post))
        expect(page).to have_content('コメントコメントコメント')
      end
    end

    context 'フォームの入力値が異常' do
      it 'コメントが未入力の場合、コメントの投稿が失敗する' do
        visit post_path(post)
        click_on '投稿'
        expect(page).to have_current_path(post_path(post))
        expect(page).to have_content('コメントを入力してください')
      end
    end
  end

  describe 'コメント削除', js: true do
    let(:post) { FactoryBot.create(:post) }
    let(:other_user) { FactoryBot.create(:user) }
  
    before do
      user = FactoryBot.create(:user)
      login_as(user)
      sleep 3
    end

    it 'ログインユーザーの場合、自身のコメントの削除が成功する' do
      visit post_path(post)
      fill_in 'コメント', with: 'コメントコメントコメント'
      click_on '投稿'
      expect(page).to have_current_path(post_path(post))
      expect(page).to have_content('1件のコメント')
      expect(page).to have_content('コメントコメントコメント')
      latest_comment = Comment.last
      find("#button-comment-delete-#{latest_comment.id}").click
      page.accept_alert 'コメントを削除します。よろしいですか？'
      expect(page).to have_content('0件のコメント')
      expect(page).not_to have_content('コメントコメントコメント')
    end

    it '他ユーザーのコメントの場合、削除ボタンが表示されない' do
      visit post_path(post)
      fill_in 'コメント', with: 'コメントコメントコメント'
      click_on '投稿'
      expect(page).to have_current_path(post_path(post))
      expect(page).to have_content('1件のコメント')
      expect(page).to have_content('コメントコメントコメント')
      click_link 'ログアウト'
      login_as(other_user)
      sleep 3
      visit post_path(post)
      latest_comment = Comment.last
      expect(page).not_to have_selector "#button-comment-delete-#{latest_comment.id}"
    end
  end
end
