# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # configuring linux box
  config.vm.define "linux", primary: true do |linux|

    linux.vm.box = "bento/ubuntu-18.04"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network "private_network", ip: "192.168.33.10"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
    linux.vm.provider "virtualbox" do |vb|
    #   # Display the VirtualBox GUI when booting the machine
    #   vb.gui = true
    #
    #   # Customize the amount of memory on the VM:
      vb.cpus = "2"
      vb.memory = "4096"
    end

    # Enable provisioning with a shell script. Additional provisioners such as
    # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
    # documentation for more information about their specific syntax and use.
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      # apt-get dist-upgrade -y
      curl -fsSL https://get.docker.com | sh
      adduser vagrant docker
    #   apt-get install -y apache2
    SHELL

    # config.vm.provision 'sonarqube', type: "shell", run: "never", path: "./prov_tools/sonarqube/notes.sh"
  end
  # config.vm.define "windows", autostart: false do |win|

  #   win.vm.box = "Microsoft/EdgeOnWindows10"

  #   # Create a private network, which allows host-only access to the machine
  #   # using a specific IP.
  #   config.vm.network "private_network", ip: "192.168.33.11"

  #   # Provider-specific configuration so you can fine-tune various
  #   # backing providers for Vagrant. These expose provider-specific options.
  #   # Example for VirtualBox:
  #   #
  #   win.vm.provider "virtualbox" do |vb|
  #   #   # Display the VirtualBox GUI when booting the machine
  #   #   vb.gui = true
  #   #
  #   #   # Customize the amount of memory on the VM:
  #     vb.cpus = "2"
  #     vb.memory = "4096"
  #   end
  # end


  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "E:\\client_name\\someDir", "/client_code"


  ##################################################
  ### Tool provisioning
  ## general SASTs
  # sonarqube
  config.vm.provision 'sonarqube', type: 'ansible_local', run: 'never' do |ansible|
    ansible.playbook = 'prov_tools/sonarqube/install.yml'
    ansible.version = 'latest'
    ansible.pip_install_cmd = "curl -fsSL https://git.io/Jt9mk | sudo bash -xs"
    ansible.install_mode = 'pip'
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/env python3"
    }
  end
  # Bandit
  config.vm.provision 'bandit', type: 'ansible_local', run: 'never' do |ansible|
    ansible.playbook = 'prov_tools/bandit/install.yml'
    ansible.version = 'latest'
    ansible.pip_install_cmd = "curl -fsSL https://git.io/Jt9mk | sudo bash -xs"
    ansible.install_mode = 'pip'
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/env python3"
    }
  end

  # MobSF
  config.vm.provision 'mobsf', type: 'ansible_local', run: 'never' do |ansible|
    ansible.playbook = 'prov_tools/MobSF/install.yml'
    ansible.version = 'latest'
    ansible.pip_install_cmd = "curl -fsSL https://git.io/Jt9mk | sudo bash -xs"
    ansible.install_mode = 'pip'
    ansible.galaxy_command = "ansible-galaxy collection install -r %{role_file} --force && ansible-galaxy role install -r %{role_file} --force"
    ansible.galaxy_role_file = "prov_vagrant/requirements.yml"
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/env python3"
    }
  end
  # Shellcheck
  config.vm.provision 'shellcheck', type: 'ansible_local', run: 'never' do |ansible|
    ansible.playbook = 'prov_tools/shellcheck.yml'
    ansible.version = 'latest'
    ansible.pip_install_cmd = "curl -fsSL https://git.io/Jt9mk | sudo bash -xs"
    ansible.install_mode = 'pip'
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/env python3"
    }
  end
  ##################################################
  ## Docker tools
  # Clair
  # config.vm.provision 'clair', type: 'ansible_local', run: 'never' do |ansible|
  #   ansible.playbook = 'prov_tools/docker/clair/install.yml'
  #   ansible.version = 'latest'
  #   ansible.extra_vars = {
  #     ansible_python_interpreter: "/usr/bin/env python3"
  #   }
  # end
  ##################################################
  ## Template
  # <Tool_name>
  # config.vm.provision '<tool_name>', type: 'ansible_local', run: 'never' do |ansible|
  #   ansible.playbook = 'prov_tools/<tool_name>/install.yml'
  #   ansible.version = 'latest'
  #   ansible.extra_vars = {
  #     ansible_python_interpreter: "/usr/bin/env python3"
  #   }
  # end
end
