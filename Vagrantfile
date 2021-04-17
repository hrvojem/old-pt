# -*- mode: ruby -*-
# vi: set ft=ruby :

playbook = "playbooks/psmdb_40.yml"
deb_distro = "bento/ubuntu-18.04"
deb1_playbook = "playbooks/pxc57.yml"
deb_common_playbook = "playbooks/pxc57_common.yml"
deb_garbd_playbook = "playbooks/pxc80_garbd.yml"
rhel_distro = "bento/centos-7"
rhel1_playbook = "playbooks/percona1_pxc57.yml"
rhel_playbook = "playbooks/percona2_pxc57.yml"
rhel_garbd_playbook = "playbooks/percona4_pxc80.yml"
node_distro = "bento/debian-10"
node_playbook = "playbooks/ms_node_80.yml"
router_playbook = "playbooks/ms_router_80.yml"

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most pxb configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define :stretch do |stretch_config|
    stretch_config.vm.box = "bento/debian-9"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    stretch_config.vm.host_name = "stretch"
    stretch_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--ioapic", "on" ]
    end
  end

  config.vm.define :buster do |buster_config|
    buster_config.vm.box = "bento/debian-10"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    buster_config.vm.host_name = "buster"
    buster_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--ioapic", "on" ]
    end
  end

  config.vm.define :xenial do |xenial_config|
    xenial_config.vm.box = "bento/ubuntu-16.04"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    xenial_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    xenial_config.vm.host_name = "xenial"
    xenial_config.vm.network :private_network, ip: "192.168.70.31"
  end

  config.vm.define :bionic do |bionic_config|
    bionic_config.vm.box = "bento/ubuntu-18.04" 
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    bionic_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    bionic_config.vm.host_name = "bionic"
    bionic_config.vm.network :private_network, ip: "192.168.70.32"
  end

  config.vm.define :focal do |focal_config|
    focal_config.vm.box = "ubuntu/focal64"
#   focal_config.vm.box = "bento/ubuntu-20.04" 
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    focal_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "8192", "--ioapic", "on" ]
    end
    focal_config.vm.host_name = "focal"
  end

  config.vm.define :groovy do |groovy_config|
    groovy_config.vm.box = "bento/ubuntu-20.10"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    groovy_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    groovy_config.vm.host_name = "groovy"
  end

  config.vm.define :centos6 do |centos6_config|
    centos6_config.vm.box = "bento/centos-6"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    centos6_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4048", "--ioapic", "on", "--cpus", "2" ]
    end
    centos6_config.vm.host_name = "centos6"
  end

  config.vm.define :centos7 do |centos7_config|
    centos7_config.vm.box = "bento/centos-7"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    centos7_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "24384", "--ioapic", "on", "--cpus", "12" ]
    end
    centos7_config.vm.host_name = "centos7"
  end

  config.vm.define :centos8 do |centos8_config|
    centos8_config.vm.box = "bento/centos-8"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    centos8_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4048", "--ioapic", "on", "--cpus", "2" ]
#     vb.customize ["modifyvm", :id, "--memory", "24384", "--ioapic", "on", "--cpus", "12" ]
    end
    centos8_config.vm.host_name = "centos8"
  end

  config.vm.define :amazon2 do |amazon2_config|
    amazon2_config.vm.box = "bento/amazonlinux-2"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    amazon2_config.vm.host_name = "amazon2"
  end

  config.vm.define :rhel8 do |rhel8_config|
    rhel8_config.vm.box = "generic/rhel8"
#   config.vm.provision "shell", path: "rhel8.sh"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.host_key_checking = "false"
    end
    rhel8_config.vm.host_name = "rhel8-ps8testing"
  end


  config.vm.define :pxc1 do |pxc1_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = deb1_playbook
      ansible.host_key_checking = "false"
    end
    pxc1_config.vm.box = deb_distro
    pxc1_config.vm.host_name = "pxc1"
    pxc1_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    pxc1_config.vm.network :private_network, ip: "192.168.70.61"
  end

  config.vm.define :pxc2 do |pxc2_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = deb_common_playbook
      ansible.host_key_checking = "false"
    end
    pxc2_config.vm.box = deb_distro
    pxc2_config.vm.host_name = "pxc2"
    pxc2_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    pxc2_config.vm.network :private_network, ip: "192.168.70.62"
  end

  config.vm.define :pxc3 do |pxc3_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = deb_common_playbook
      ansible.host_key_checking = "false"
    end
    pxc3_config.vm.box = deb_distro
    pxc3_config.vm.host_name = "pxc3"
    pxc3_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    pxc3_config.vm.network :private_network, ip: "192.168.70.63"
  end

  config.vm.define :pxc4 do |pxc4_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = deb_garbd_playbook
      ansible.host_key_checking = "false"
    end
    pxc4_config.vm.box = deb_distro
    pxc4_config.vm.host_name = "pxc4"
    pxc4_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    pxc4_config.vm.network :private_network, ip: "192.168.70.64"
  end

  config.vm.define :percona1 do |percona1_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = rhel1_playbook
      ansible.host_key_checking = "false"
    end
    percona1_config.vm.box = rhel_distro
    percona1_config.vm.host_name = "percona1"
    percona1_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    percona1_config.vm.network :private_network, ip: "192.168.70.71"
  end
  config.vm.define :percona2 do |percona2_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = rhel_playbook
      ansible.host_key_checking = "false"
    end
    percona2_config.vm.box = rhel_distro
    percona2_config.vm.host_name = "percona2"
    percona2_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
   percona2_config.vm.network :private_network, ip: "192.168.70.72"
  end
  config.vm.define :percona3 do |percona3_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = rhel_playbook
      ansible.host_key_checking = "false"
    end
    percona3_config.vm.box = rhel_distro
    percona3_config.vm.host_name = "percona3"
    percona3_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    percona3_config.vm.network :private_network, ip: "192.168.70.73"
  end

  config.vm.define :percona4 do |percona4_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = rhel_garbd_playbook
      ansible.host_key_checking = "false"
    end
    percona4_config.vm.box = rhel_distro
    percona4_config.vm.host_name = "percona4"
    percona4_config.vm.network :private_network, ip: "192.168.70.74"
  end

  config.vm.define :ps_node1 do |ps_node1_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = node_playbook
      ansible.host_key_checking = "false"
    end
    ps_node1_config.vm.box = node_distro
    ps_node1_config.vm.host_name = "ps-node1"
    ps_node1_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    ps_node1_config.vm.network :private_network, ip: "192.168.80.71"
  end

  config.vm.define :ps_node2 do |ps_node2_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = node_playbook
      ansible.host_key_checking = "false"
    end
    ps_node2_config.vm.box = node_distro
    ps_node2_config.vm.host_name = "ps-node2"
    ps_node2_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
   ps_node2_config.vm.network :private_network, ip: "192.168.80.72"
  end

  config.vm.define :ps_node3 do |ps_node3_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = node_playbook
      ansible.host_key_checking = "false"
    end
    ps_node3_config.vm.box = node_distro
    ps_node3_config.vm.host_name = "ps-node3"
    ps_node3_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    ps_node3_config.vm.network :private_network, ip: "192.168.80.73"
  end

  config.vm.define :router do |router_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = router_playbook
      ansible.host_key_checking = "false"
    end
    router_config.vm.box = node_distro
    router_config.vm.host_name = "mysql-router"
    router_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    router_config.vm.network :private_network, ip: "192.168.80.74"
  end
end
