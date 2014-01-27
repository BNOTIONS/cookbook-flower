# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "flower-berkshelf"

  config.vm.box = "ubuntu-12.04-omnibus-chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  config.vm.network :forwarded_port, guest: 5555, host: 5555

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'build_essential' => {
        'compiletime' => true
      },
      'flower' => {
        'autostart' => true,
        'basic_auth' => 'flower:flower',
        'enable_ssl' => true,
        'listen_address' => '0.0.0.0',
        'ssl_cert' => '/vagrant/test/cert/server.cert',
        'ssl_key' => '/vagrant/test/cert/server.key',
        'virtualenv' => '/tmp/venv-flower'
      }
    }

    chef.run_list = [
        "recipe[rabbitmq]",
        "recipe[supervisor]",
        "recipe[flower::default]"
    ]
  end
end
