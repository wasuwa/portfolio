require 'rails_helper'

RSpec.describe "Articles", type: :feature do

    let!(:article) { create(:article) }
    let(:user) { create(:user) }

    describe 'create', type: :request do

        let!(:article) { attributes_for(:article) }
        let(:post_request) { post articles_path, params: { article: article } }

        context 'view of other users' do
            it 'valid' do
                expect{post_request}.to change(Article, :count).by(0)
                expect(post_request).to redirect_to login_url
            end
        end
    end

    describe 'delete', type: :request do

        let(:delete_request) { delete article_path(article) }

        context 'other users delete articles' do
            it 'valid' do
                log_in_as(user)
                expect{delete_request}.to change(Article, :count).by(0)
            end
        end
    end
end