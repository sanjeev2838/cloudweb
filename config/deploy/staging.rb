role :app, %w{dev.wermlandsoftware.com}
role :web, %w{dev.wermlandsoftware.com}
role :db,  %w{dev.wermlandsoftware.com}

server 'dev.wermlandsoftware.com', user: 'pardeep', roles: %w{web app}, my_property: :my_value

set :branch, 'master'
set :rails_env, "staging"

set :deploy_to, "/home/sanjeev/cloudweb1"

set :domain, "staging.dev.wermlandsoftware.com"



# and/or per server
server 'dev.wermlandsoftware.com',
   user: 'root',
   roles: %w{web app},
   ssh_options: {
     user: 'root', # overrides user setting above
     keys: %w(/home/pardeepkumar/.ssh/id_rsa),
     forward_agent: false,
     auth_methods: %w(publickey password),
     password: 'W0lver1ne'
   }
# setting per server overrides global ssh_options
