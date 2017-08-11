# -*- mode: ruby -*-
# vi: set ft=ruby :

playbook = "playbooks/common_57.yml"
deb_distro = "bento/ubuntu-16.04"
deb1_playbook = "playbooks/pxc57.yml"
deb_common_playbook = "playbooks/pxc57_common.yml"
deb_garbd_playbook = "playbooks/pxc57_garbd.yml"
rhel_distro = "bento/centos-7.3"
rhel1_playbook = "playbooks/percona1_pxc57.yml"
rhel_playbook = "playbooks/percona2_pxc57.yml"
rhel_garbd_playbook = "playbooks/percona4_pxc57.yml"

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most pxb configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define :wheezy do |wheezy_config|
    wheezy_config.vm.box = "bento/debian-7.11"
#   wheezy_config.vm.box = "bento/debian-7.11-i386"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    wheezy_config.vm.host_name = "wheezy"
  end

  config.vm.define :jessie do |jessie_config|
    jessie_config.vm.box = "bento/debian-8.8"
#   jessie_config.vm.box = "bento/debian-8.8-i386"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    jessie_config.vm.host_name = "jessie"
    jessie_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--ioapic", "on" ]
    end
  end

  config.vm.define :stretch do |stretch_config|
    stretch_config.vm.box = "bento/debian-9.0"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    stretch_config.vm.host_name = "stretch"
    stretch_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--ioapic", "on" ]
    end
  end

  config.vm.define :trusty do |trusty_config|
    trusty_config.vm.box = "bento/ubuntu-14.04"
#   trusty_config.vm.box = "bento/ubuntu-14.04-i386"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    trusty_config.vm.host_name = "trusty"
    trusty_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--ioapic", "on" ]
    end
  end

  config.vm.define :xenial do |xenial_config|
    xenial_config.vm.box = "bento/ubuntu-16.04"
#   xenial_config.vm.box = "bento/ubuntu-16.04-i386"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    xenial_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    xenial_config.vm.host_name = "xenial"
  end

  config.vm.define :yakkety do |yakkety_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    yakkety_config.vm.box = "bento/ubuntu-16.10"
#   yakkety_config.vm.box = "bento/ubuntu-16.10-i386"
    yakkety_config.vm.host_name = "yakkety"
    yakkety_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--ioapic", "on" ]
    end
  end

  config.vm.define :zesty do |zesty_config|
    zesty_config.vm.box = "bento/ubuntu-17.04"
    config.vm.provision "shell", path: "zesty.sh"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    zesty_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on" ]
    end
    zesty_config.vm.host_name = "zesty"
  end

  config.vm.define :centos6 do |centos6_config|
    centos6_config.vm.box = "bento/centos-6.9"
#   centos6_config.vm.box = "bento/centos-6.8-i386"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    centos6_config.vm.host_name = "centos6"
  end

  config.vm.define :centos7 do |centos7_config|
    centos7_config.vm.box = "bento/centos-7.3"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    centos7_config.vm.host_name = "centos7"
  end

  config.vm.define :pxc1 do |pxc1_config|
    if deb_distro == "ubuntu/zesty64" then
       config.vm.provision "shell", path: "zesty.sh"
    end   
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = deb1_playbook
      ansible.sudo = "true"
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
    if deb_distro == "ubuntu/zesty64" then
       config.vm.provision "shell", path: "zesty.sh"
    end   
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = deb_common_playbook
      ansible.sudo = "true"
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
    if deb_distro == "ubuntu/zesty64" then
       config.vm.provision "shell", path: "zesty.sh"
    end   
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = deb_common_playbook
      ansible.sudo = "true"
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
    if deb_distro == "ubuntu/zesty64" then
       config.vm.provision "shell", path: "zesty.sh"
    end   
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = deb_garbd_playbook
      ansible.sudo = "true"
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
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    percona1_config.vm.box = rhel_distro
    percona1_config.vm.host_name = "percona1"
    percona1_config.vm.network :private_network, ip: "192.168.70.71"
  end
  config.vm.define :percona2 do |percona2_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = rhel_playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    percona2_config.vm.box = rhel_distro
    percona2_config.vm.host_name = "percona2"
   percona2_config.vm.network :private_network, ip: "192.168.70.72"
  end
  config.vm.define :percona3 do |percona3_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = rhel_playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    percona3_config.vm.box = rhel_distro
    percona3_config.vm.host_name = "percona3"
    percona3_config.vm.network :private_network, ip: "192.168.70.73"
  end

  config.vm.define :percona4 do |percona4_config|
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = rhel_garbd_playbook
      ansible.sudo = "true"
      ansible.host_key_checking = "false"
    end
    percona4_config.vm.box = rhel_distro
    percona4_config.vm.host_name = "percona4"
    percona4_config.vm.network :private_network, ip: "192.168.70.74"
  end

  config.vm.define :freebsd do |freebsd_config|
    freebsd_config.vm.box = "bento/freebsd-11.0"
    freebsd_config.vm.host_name = "freebsd"
  end

end
