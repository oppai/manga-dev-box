# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install Ruby ruby2.2 ruby2.2-dev
update-alternatives --set ruby /usr/bin/ruby2.2 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.2 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install Git git
install Redis redis-server

debconf-set-selections <<< 'mysql-server mysql-server/root_password password '
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password '
install MySQL mysql-server libmysqlclient-dev
mysql -uroot <<SQL
CREATE USER 'manga'@'localhost';
SQL

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

install Zsh zsh
install Tmux tmux
install Tig tigvim
install JQ jq
#chsh -s /usr/bin/zsh vagrant
#su vagrant << EOF
#  if [ ! -f ~/.dotfiles ]; then
#    cd ~/ && git clone https://github.com/oppai/.dotfiles && cd ~/.dotfiles && sh ./setup.sh
#  fi
#EOF

echo 'all set, rock on!'
