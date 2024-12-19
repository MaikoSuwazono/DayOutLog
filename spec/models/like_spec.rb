require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post) }
  let(:post2) { FactoryBot.create(:post) }
  
  describe 'バリデーション' do
    context 'すべてのカラム' do
      it '設定したすべてのバリデーションが機能しているか' do
        like = FactoryBot.build(:like, user: user1, post: post1)
        expect(like).to be_valid
        expect(like.errors).to be_empty
      end
    end

    context 'post_idカラム' do
      it 'post_idがない場合にバリデーションが機能してinvalidになるか' do
        like_without_post_id = FactoryBot.build(:like, user: user1, post_id: "")
        expect(like_without_post_id).to be_invalid
        expect(like_without_post_id.errors[:post_id]).to eq ["を入力してください"]
      end
    end

    context 'user_idカラム' do
      it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
        like_without_user_id = FactoryBot.build(:like, user_id: "", post: post1)
        expect(like_without_user_id).to be_invalid
        expect(like_without_user_id.errors[:user_id]).to eq ["を入力してください"]
      end

      it "user_idが同じでもpost_idが違うと保存できる" do
        like = FactoryBot.create(:like, user: user1, post: post1)
        expect(FactoryBot.build(:like, user: user1, post: post2)).to be_valid
      end

      it "user_idとpost_idが同じだと保存できない" do
        like = FactoryBot.create(:like, user: user1, post: post1)
        like_duplicate = FactoryBot.build(:like, user: user1, post: post1)
        expect(like_duplicate).to be_invalid
        expect(like_duplicate.errors[:user_id]).not_to be_empty
      end
    end
  end
end
