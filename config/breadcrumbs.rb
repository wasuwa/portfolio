crumb :root do
  link "ホーム", root_path
end

crumb :account_setting do
  link "アカウントの設定", account_setting_path
  parent :root
end

crumb :password_setting do
  link "パスワードの設定", password_setting_path
  parent :root
end

crumb :login do
  link "ログイン", login_path
  parent :root
end

crumb :sign_up do
  link "新規登録", sign_up_path
  parent :root
end

crumb :email do
  link "メール認証", email_path
  parent :root
end

crumb :profile do
  link "ユーザー名", profile_path
  parent :root
end

crumb :article_details do
  link "記事タイトル", article_details_path
  parent :profile
end

crumb :other_profile do
  link "ユーザー名（他人）", other_profile_path
  parent :root
end

crumb :new_articles_list do
  link "新着記事", new_articles_list_path
  parent :root
end

crumb :favorite_list do
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