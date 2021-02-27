# EC2の情報
server '18.181.158.76', user: 'ec2-user', roles: %w[app db web]

# 公開鍵
set :ssh_options, {
  keys: %w[~/.ssh/github_rsa],
  forward_agent: true,
  auth_methods: %w[publickey],
  port: 22
}
