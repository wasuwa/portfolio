crumb :root do
  link "ホーム", root_path
end

crumb :account_setting do |account_setting|
  link "アカウントの設定", account_setting_path
  parent :root
end

crumb :password_setting do |password_setting|
  link "パスワードの設定", password_setting_path
  parent :root
end

crumb :login do |login|
  link "ログイン", login_path
  parent :root
end

crumb :sign_up do |sign_up|
  link "新規登録", sign_up_path
  parent :root
end

crumb :email do |email|
  link "メール認証", email_path
  parent :root
end

crumb :profile do |profile|
  link "ユーザー名", profile_path
  parent :root
end

crumb :article_details do |article_details|
  link "記事タイトル", '/profile/article_details'
  parent :profile
end

crumb :article_posting do |article_posting|
  link "記事投稿", article_posting_path
  parent :profile, profile
end

crumb :other_profile do |other_profile|
  link "ユーザー名（他人）", other_profile_path
  parent :root
end

crumb :new_articles_list do |new_articles_list|
  link "新着記事", new_articles_list_path
  parent :root
end

crumb :favorite_list do |favorite_list|
  link "お気に入り", favorite_list_path
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).