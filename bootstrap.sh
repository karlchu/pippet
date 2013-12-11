#/usr/bin/env bash

if [ `whoami` != 'root' ]
then
    echo 'Must be root to run this'
    exit 1
fi

apt-get install -y git
apt-get install -y zlib1g-dev
apt-get install -y openssl
apt-get install -y libopenssl-ruby1.9.1
apt-get install -y libssl-dev
apt-get install -y libruby1.9.1
apt-get install -y libreadline-dev

# clone the rbenv repo and setup the env
RBENV_ROOT=/opt/rbenv
if [ -d $RBENV_ROOT ]; then
  cd $RBENV_ROOT
  git pull
else
  rm -rf "$RBENV_ROOT"
  git clone git://github.com/sstephenson/rbenv.git "$RBENV_ROOT"
fi
echo "export RBENV_ROOT=\"$RBENV_ROOT\"" > /etc/profile.d/rbenv.sh
echo "export PATH=\"$RBENV_ROOT/bin:$PATH\"" >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
. /etc/profile.d/rbenv.sh

# add the ruby-build plugin and install a ruby 1.9.3
RUBY_BUILD=$RBENV_ROOT/plugins/ruby-build
if [ -d $RUBY_BUILD ]; then
  cd $RUBY_BUILD
  git pull
else
  git clone git://github.com/sstephenson/ruby-build.git $RUBY_BUILD
fi
rbenv rehash
#echo "========================================"
#echo "** Installing 1.9.3-p484"
#date
#rbenv install 1.9.3-p484
#echo "** Finish install 1.9.3-p484"
#date
echo "========================================"
echo "** Installing 1.8.7-p374"
date
rbenv install 1.8.7-p374
echo "** Finish install 1.8.7-p374"
date
echo "========================================"
# set the ruby as the global ruby version
#rbenv global 1.9.3-p484
rbenv global 1.8.7-p374
rbenv rehash
# check if it's working fine
ruby -v
date
