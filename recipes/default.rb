#
# Cookbook:: typo3-flow
# Recipe:: default.rb
#
# Copyright 2013, Thomas Layh
#
# Version 0.1
#
# Install a blank TYPO3Flow + Welcome Package + DevStuff

include_recipe "typo3-flow::basic"

# setup host
cookbook_file "/etc/nginx/sites-available/typo3.flow" do
	source "typo3.flow"
	mode 0755
end

# prepare php.ini config
cookbook_file "/etc/php5/conf.d/php_dateTimeZone.ini" do
	source "php_dateTimeZone.ini"
	mode 0655
end

package "php5-fpm" do
  action :install
end

template "upstream_php-fpm.conf" do
  path "#{node['nginx']['dir']}/conf.d/fpm.conf"
  source "upstream_php-fpm.conf.erb"
  owner "root"
  group "root"
  mode 00644
end

service "php5-fpm" do
  action :start
end

# enable host and disable default host
nginx_site "000-default" do
	enable false
end
nginx_site "typo3.flow" do
	enable true
	notifies :reload, 'service[nginx]'
end

# clone and install typo3flow
execute "clone typo3.flow base" do
	command "git clone git://git.typo3.org/FLOW3/Distributions/Base.git /var/www/typo3.flow"
	creates "/var/www/typo3.flow/"
end

execute "get composer" do
	command "curl -s https://getcomposer.org/installer | php"
	cwd "/var/www/typo3.flow"
end

execute "install TYPO3.Flow" do
	command "php composer.phar install --dev"
	cwd "/var/www/typo3.flow"
end

execute "fixing permissions" do
	command "Packages/Framework/TYPO3.Flow/Scripts/setfilepermissions.sh vagrant vagrant www-data"
	cwd "/var/www/typo3.flow/"
end