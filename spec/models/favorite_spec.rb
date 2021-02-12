require 'rails_helper'

RSpec.describe Favorite, :type => :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  describe "dependent: :destroy" do
    before do
      article.favorites.create!(:user_id => user.id)
    end

    context 'articleを削除した場合' do
      example 'articleと同時にfavoriteも削除される' do
        expect do
          article.destroy
        end.to change(Favorite, :count).by(-1)
      end
    end
  end
end
