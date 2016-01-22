# == Class: graphite
#
# Full description of class graphite here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { graphite:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class graphite (
  $graphite_package = $::graphite::params::graphite_package,
  $carbon_package = $::graphite::params::carbon_package,
  $whisper_package = $::graphite::params::whisper_package,
  $carbon_relay_service = $::graphite::params::carbon_relay_service,
  $carbon_cache_service = $::graphite::params::carbon_cache_service,
  $vhost_name = $::graphite::params::vhost_name,
) inherits graphite::params {
  class { 'graphite::install': } ->
  class { 'graphite::config': } ~>
  class { 'graphite::service': } ->
  Class['graphite']
}
