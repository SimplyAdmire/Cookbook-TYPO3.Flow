default['composer']['install_globally'] = "true"
default['php-fpm']['pool']['www']['listen'] = "9000"

default['nginx']['worker_processes']  = "1024"
default['nginx']['gzip']              = "on"
default['nginx']['gzip_http_version'] = "1.0"
default['nginx']['gzip_comp_level']   = "9"
default['nginx']['gzip_proxied']      = "any"
default['nginx']['gzip_vary']         = "on"
default['nginx']['gzip_types']        = [
  "text/plain",
  "text/css",
  "application/x-javascript",
  "text/xml",
  "application/xml",
  "application/xml+rss",
  "text/javascript",
  "application/javascript",
  "application/json"
]