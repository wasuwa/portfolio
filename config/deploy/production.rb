# EC2の情報
server '18.181.158.76', user: 'suwa', roles: %w[app db web]

# sshログインする鍵
set :ssh_options, keys: '~/.ssh/portfolio_key_rsa'
