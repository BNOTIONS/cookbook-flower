# Description

Installs and configures [flower](https://github.com/mher/flower), a basic monitoring tool for celery clusters.

# Requirements

## Platforms

Tested on ubuntu 12.04, but should work on any popular linux distro.

## Cookbooks

* `build-essential` - Required for python-dev/pip.
* `python` - Required for pip and virtualenv providers.
* `supervisor` - Used to daemonize flower.
* `rabbitmq` - Included in Berkfile but not directly a cookbook dependancy. Mostly used for testing the default broker attributes.


# Usage

Simply add `recipe[flower]` to your runlist after your broker is installed, or `include_recipe 'flower'` in your own cookbooks.

# Attributes

* `node[:flower][:skip_install]` - Skip installing flower and dependancies. Useful if you bundle flower in your projects requirements.txt.
* 
* `node[:flower][:user]` - User that will run the flower deamon.
* `node[:flower][:version]` - Version of flower to install.
* `node[:flower][:virtualenv]` - Virtualenv path to be created.
* `node[:flower][:autostart]` - Autostart supervisor daemon.
* `node[:flower][:autostart]` - Autostart supervisor daemon.
* `node[:flower][:basic_auth]` - Basic authentication in the form of 'username:password'.
* `node[:flower][:auth]` - Regular expression matching email addresses.
* `node[:flower][:listen_address]` - IP address to listen on.
* `node[:flower][:listen_port]` - Port to listen on.
* `node[:flower][:ssl_cert]` - Path to ssl certificate.
* `node[:flower][:ssl_key]` - Path to ssl key.
* `node[:flower][:broker][:protocol]` - Celery broker protocol.
* `node[:flower][:broker][:host]` - Celery broker host.
* `node[:flower][:broker][:username]` - Celery broker username.
* `node[:flower][:broker][:password]` - Celery broker password.
* `node[:flower][:broker][:port]` - Celery broker port.
* `node[:flower][:broker][:vhost]` - Celery broker vhost.

# Recipes

* `default` - Installs flower, unless skip_install attribute is true, and creates a supervisor daemon to run it.

# To Do

* Proper cookbook tests
* Travis CI integration


# Author

Author:: Jonathon W. Marshall (<jonathon@bnotions.com>)
