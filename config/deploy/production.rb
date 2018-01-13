server '13.230.181.126', user: 'app', roles: %w{app db web}

set :ssh_options, keys: '/home/vagrant/.ssh/id_rsa'
