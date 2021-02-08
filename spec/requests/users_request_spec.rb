require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:user) { build(:user) }
    let(:login_user) { create(:user) }
    let(:another_user) { create(:user) }

    describe "new" do
        context "有効なパラメータが送信された場合" do
            example "リクエストが成功する" do
                get signup_path
                expect(response.status).to eq 200
            end
        end
    end
    
    describe "create" do
        let(:user_invalid) { User.create() }

        context "有効なパラメータが送信された場合" do
            example "リクエストが成功する" do
                post users_path, params: { user: attributes_for(:user) }
                expect(response.status).to eq 302
            end
            example "新規登録に成功する" do
                expect do
                    user.save
                end.to change(User, :count).by(+1)
            end
        end
        
        context "無効なパラメータが送信された場合" do
            example "新規登録に失敗する" do
                expect do
                    user_invalid.save
                end.to change(User, :count).by(0)
            end
        end
    end

    describe "show" do
        context "有効なパラメータが送信された場合" do
            example "リクエストが成功する" do
                get user_path(login_user)
                expect(response.status).to eq 200
            end
        end
    end

    describe "update", type: :feature do
        context "有効な情報を送信した場合" do
            before do
                log_in_as(login_user)
                visit edit_user_path(login_user)
                fill_in 'user_name', with: "NewName"
                select 2, from: "高校の学年"
                fill_in 'user_email', with: "new@new.com"
                fill_in 'user_password', with: login_user.password = "newnew"
                fill_in 'user_password_confirmation', with: login_user.password_confirmation = "newnew"
                click_on "更新する"
            end
            
            example "userが更新される" do
                login_user.reload
                expect(login_user.name).to eq "NewName"
                expect(login_user.email).to eq "new@new.com"
                expect(login_user.grade).to eq 2
                expect(login_user.password).to eq "newnew"
                expect(login_user.password_confirmation).to eq "newnew"
            end

            example "userの個別ページにリダイレクトされる" do
                expect(current_path).to eq user_path(login_user)
            end
        end
        
        context "無効なパラメータが送信された場合" do
            before do
                log_in_as(login_user)
                visit edit_user_path(login_user)
                fill_in 'user_name', with: ""
                fill_in 'user_email', with: ""
                fill_in 'user_password', with: login_user.password = ""
                fill_in 'user_password_confirmation', with: login_user.password_confirmation = ""
                click_on "更新する"
            end
            example "userが更新されない" do
                login_user.reload
                expect(login_user.name).to eq login_user.name
                expect(login_user.email).to eq login_user.email
                expect(login_user.grade).to eq login_user.grade
                expect(login_user.password).to eq login_user.password
                expect(login_user.password_confirmation).to eq login_user.password_confirmation
            end
            example "元のページにリダイレクトされる" do
                expect(current_path).to eq user_path(login_user)
            end
            example "エラーメッセージが表示される" do
                expect(page).to have_content "名前を入力してください"
                expect(page).to have_content "メールアドレスを入力してください"
            end
        end

        context "パスワード、パスワードの確認が空の場合" do
            before do
                log_in_as(login_user)
                visit edit_user_path(login_user)
                fill_in 'user_name', with: "pass_nil"
                click_on "更新する"
            end
            example "userが更新される" do
                login_user.reload
                expect(login_user.name).to eq "pass_nil"
            end
        end

        context "パスワードのみが空の場合" do
            before do
                log_in_as(login_user)
                visit edit_user_path(login_user)
                fill_in 'user_password', with: login_user.password = ""
                fill_in 'user_password_confirmation', with: login_user.password_confirmation = "aaaaaa"
                click_on "更新する"
            end
            example "userが更新されない" do
                expect(login_user.password).to eq login_user.password
            end
            example "エラーメッセージが表示される" do
                expect(page).to have_content "パスワードを入力してください"
            end
        end

        context "パスワードの確認のみが空の場合" do
            before do
                log_in_as(login_user)
                visit edit_user_path(login_user)
                fill_in 'user_password', with: login_user.password = "aaaaaa"
                fill_in 'user_password_confirmation', with: login_user.password_confirmation = ""
                click_on "更新する"
            end
            example "userが更新されない" do
                expect(login_user.password).to eq login_user.password
            end
            example "エラーメッセージが表示される" do
                expect(page).to have_content "確認とパスワードの入力が一致しません"
            end
        end
    end

    describe "before", type: :feature do
        context "有効なuserがeditにアクセスした場合" do
            before do
                log_in_as(login_user)
                visit edit_user_path(login_user)
            end
            example "editテンプレートが表示される" do
                expect(current_path).to eq edit_user_path(login_user)
            end
        end

        context "他のuserがeditにアクセスした場合" do
            before do
                log_in_as(login_user)
                visit edit_user_path(another_user)
            end
            example "root_pathにリダイレクトされる" do
                expect(current_path).to eq root_path
            end
            example "エラーメッセージが表示される" do
                expect(page).to have_content "他のユーザーのプロフィールは編集できません"
            end
        end

        context "他のユーザーがpatchリクエストを送信した場合" do
            before do
                log_in_as(another_user)
            end
            example "login_pathにリダイレクトされる" do
                patch user_path(login_user), params: { user: {
                                    name: login_user.name,
                                    email: login_user.email
                } }
                expect(response).to redirect_to login_path
            end
        end
        
        context "未ログインのユーザーがeditにアクセスした場合" do
            before do
                visit edit_user_path(login_user)
            end
            example "login_pathにリダイレクトされる" do
                expect(current_path).to eq login_path
            end
            example "エラーメッセージが表示される" do
                expect(page).to have_content "この機能を使うためにはログインが必要です"
            end
        end

        context "未ログインのユーザーがpatchリクエストを送信した場合" do
            example "login_pathにリダイレクトされる" do
                patch user_path(login_user), params: { user: {
                                    name: login_user.name,
                                    email: login_user.email
                } }
                expect(response).to redirect_to login_path
            end
        end

        context "元ページの情報はログイン時に削除される" do
            before do
                visit edit_user_path(login_user)
                log_in_as(login_user)
                expect(current_path).to eq edit_user_path(login_user)
                within '.hamburger_nav' do
                    click_link 'ログアウト'
                end
            end
            example "2回目からはuser_pathにリダイレクトされる" do
                log_in_as(login_user)
                expect(current_path).to eq user_path(login_user)
            end
        end
    end
end
