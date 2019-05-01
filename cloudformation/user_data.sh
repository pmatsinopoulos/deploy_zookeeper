#!/usr/bin/env bash
source /etc/lsb-release
wget https://apt.puppetlabs.com/puppet5-release-${DISTRIB_CODENAME}.deb
dpkg -i puppet5-release-${DISTRIB_CODENAME}.deb
apt-get update
apt-get -y install gcc make git
apt-get -y install puppet-agent
echo 'Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin"' >/etc/sudoers.d/puppet

cd /opt/puppetlabs/bin && ln -s ../puppet/bin/gem gem

gem install gpgme --no-rdoc --no-ri
gem install hiera-eyaml-gpg --no-rdoc --no-ri

gem install r10k --no-rdoc --no-ri
cd /opt/puppetlabs/bin && ln -s ../puppet/bin/r10k r10k

gem install generate-puppetfile --no-rdoc --no-ri
cd /opt/puppetlabs/bin && ln -s ../puppet/bin/generate-puppetfile generate-puppetfile

mv /etc/puppetlabs/code/environments/production /etc/puppetlabs/code/environments/production.sample
cd /etc/puppetlabs/code/environments && git clone https://github.com/pmatsinopoulos/deploy_zookeeper.git production

cd production/puppet

r10k puppetfile install --verbose

/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/puppet/manifests/