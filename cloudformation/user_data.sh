#!/usr/bin/env bash
source /etc/lsb-release
wget https://apt.puppetlabs.com/puppet5-release-${DISTRIB_CODENAME}.deb
dpkg -i puppet-release5-${DISTRIB_CODENAME}.deb
apt-get update
apt-get -y install gcc make git
apt-get -y install puppet-agent
echo 'Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin"' >/etc/sudoers.d/puppet
/opt/puppetlabs/puppet/bin/gem install gpgme --no-rdoc --no-ri
/opt/puppetlabs/puppet/bin/gem install hiera-eyaml-gpg --no-rdoc --no-ri
/opt/puppetlabs/puppet/bin/gem install r10k --no-rdoc --no-ri
mv /etc/puppetlabs/code/environments/production /etc/puppetlabs/code/environments/production.sample
cd /etc/puppetlabs/code/environments && git clone https://github.com/pmatsinopoulos/deploy_zookeeper.git production
/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/puppet/manifests/
