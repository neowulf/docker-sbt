# -*- mode: ruby -*-
# vi: set ft=ruby :

# vagrant init ubuntu/trusty64; vagrant up --provider virtualbox

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL

    sudo su

    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
      add-apt-repository -y ppa:webupd8team/java && \
      apt-get update && \
      apt-get install -y oracle-java8-installer && \
      rm -rf /var/lib/apt/lists/* && \
      rm -rf /var/cache/oracle-jdk8-installer

    ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
  SHELL
end
