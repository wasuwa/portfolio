# EC2の情報
server '18.181.158.76', user: 'ec2-user', roles: %w[app db web]

# 公開鍵
set :ssh_options, {
  keys: %w[~/.ssh/id_rsa_332e96a4b1d559603760566dac7d31e2],
  forward_agent: true,
  auth_methods: %w[publickey],
  port: 22
}
