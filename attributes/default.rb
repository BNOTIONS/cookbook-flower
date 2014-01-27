
default[:flower][:skip_install] = false

default[:flower][:user] = 'nobody'
default[:flower][:version] = '0.6.0'
default[:flower][:virtualenv] = nil
default[:flower][:autostart] = true
default[:flower][:autorestart] = true

default[:flower][:basic_auth] = nil
default[:flower][:auth] = nil

default[:flower][:listen_address] = '127.0.0.1'
default[:flower][:listen_port] = '5555'

default[:flower][:ssl_cert] = 'server.cert'
default[:flower][:ssl_key] = 'server.key'

default[:flower][:broker][:protocol] = 'amqp'
default[:flower][:broker][:host] = 'localhost'
default[:flower][:broker][:username] = 'guest'
default[:flower][:broker][:password] = 'guest'
default[:flower][:broker][:port] = 5672
default[:flower][:broker][:vhost] = '/'

