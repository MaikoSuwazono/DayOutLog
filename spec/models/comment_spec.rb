require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  
  describe 'バリデーション' do
    context 'すべてのカラム' do
      it '設定したすべてのバリデーションが機能しているか' do
        comment = FactoryBot.build(:comment, user: user, post: post)
        expect(comment).to be_valid
        expect(comment.errors).to be_empty
      end
    end

    context 'user_idカラム' do
      it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
        comment_without_user_id = FactoryBot.build(:comment, post: post, user_id: "")
        expect(comment_without_user_id).to be_invalid
        expect(comment_without_user_id.errors[:user_id]).to eq ["を入力してください"]
      end
    end

    context 'bodyカラム' do
      it 'bodyがない場合にバリデーションが機能してinvalidになるか' do
        comment_without_body = FactoryBot.build(:comment, body: "", user: user, post: post)
        expect(comment_without_body).to be_invalid
        expect(comment_without_body.errors[:body]).to eq ["を入力してください"]
      end

      it 'bodyが65,535文字以下であること: 65,535文字はOK' do
        comment = FactoryBot.build(:comment, body: Faker::Lorem.characters(number: 65535), user: user, post: post)
        expect(comment).to be_valid
        expect(comment.errors[:body]).to be_empty
      end

      it 'bodyが65,535文字以下であること: 65,536文字はNG' do
        comment = FactoryBot.build(:comment, body: Faker::Lorem.characters(number: 65536), user: user, post: post)
        expect(comment).to be_invalid
        expect(comment.errors[:body]).not_to be_empty
      end
    end
  end
end
