#! /bin/bash
# Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

# BOTCH: fragile YAML parser to avoid circular dependency on ruby
parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

eval $(parse_yaml /etc/build/versions.yml "version_")

apt-get -y update
apt-get -y upgrade

apt-get clean

groupadd -r ruby

# Install rbenv and ruby-build
git clone https://github.com/sstephenson/rbenv.git /usr/local/ruby
git clone https://github.com/sstephenson/ruby-build.git /usr/local/ruby/plugins/ruby-build
/usr/local/ruby/plugins/ruby-build/install.sh

echo 'export RBENV_ROOT="/usr/local/ruby"' >> /etc/profile.d/rbenv.sh
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

# Install ruby using rbenv
export CONFIGURE_OPTS="--disable-install-doc"
rbenv install ${version_ruby}
rbenv global ${version_ruby}

echo 'gem: --no-rdoc --no-ri' >> /.gemrc
gem install bundler

chgrp -R ruby /usr/local/ruby
find /usr/local/ruby -type d | xargs chmod g+w
