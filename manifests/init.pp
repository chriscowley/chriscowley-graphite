# == Class: graphite
#
# Full description of class graphite here.
#
# === Parameters
#
# [*secret_key*]
# Secret key for Django/Graphite-web
# Default is "secret"
# CHANGE IT
#
# [*gr_storage_schemas*]
#   
#   Storage schemas to us
#   Default is:
#    [carbon]
#    pattern = ^carbon\.
#    retentions = 60:90d
#
#    [default_1min_for_1day]
#    pattern = .*
#    retentions = 60s:1d
#
#  [*gr_max_updates_per_second*]
#   Limits the number of whisper update_many() calls per second, which
#   effectively means the number of write requests sent to the disk.
#   Default is 500.
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
#    gr_storage_schemas [
#      {
#        name       => 'hosts',
#        pattern    => '^hosts\.',
#        retentions => '10s:1d,1m:7d,10m:2y',
#      },
#      {
#        name       => 'carbon',
#        pattern    => '^carbon\.',
#        retentions => '1m:90d',
#      },
#      {
#        name       => 'default_1min_for_1day',
#        pattern    => '.*',
#        retentions => '1m:1d',
#      },
#    ],
#  }
#
# === Authors
#
# Chris Cowley <chris@chriscowley.me.uk>
#
# === Copyright
#
# Copyright 2016 Chris Cowley
#
class graphite (
  $secret_key = $::graphite::params::secret_key,
  $graphite_package = $::graphite::params::graphite_package,
  $carbon_package = $::graphite::params::carbon_package,
  $whisper_package = $::graphite::params::whisper_package,
  $carbon_relay_service = $::graphite::params::carbon_relay_service,
  $carbon_cache_service = $::graphite::params::carbon_cache_service,
  $vhost_name = $::graphite::params::vhost_name,
  $relay_type = $::graphite::params::relay_type,
  $relay_package = $::graphite::params::relay_package,
  $gr_storage_schemas = $::graphite::params::gr_storage_schemas,
  $gr_relay_rules = $::graphite::params::gr_relay_rules,
  $gr_storage_dir = $::graphite::params::gr_storage_dir,
  $gr_local_data_dir = $::graphite::params::gr_local_data_dir,
  $gr_conf_dir = $::graphite::params::gr_whitelists_dir,
  $gr_max_updates_per_second = $::graphite::params::gr_max_updates_per_second,
  $gr_max_updates_per_second_on_shutdown = $::graphite::params::gr_max_updates_per_second_on_shutdown,
  $gr_max_creates_per_minute = $graphite::params::gr_max_creates_per_minute,
  $gr_line_receiver_port = $graphite::params::gr_line_receiver_port,
  $gr_line_receiver_interface = $graphite::params::gr_line_receiver_interface,
  $gr_pickle_receiver_port = $graphite::params::gr_pickle_receiver_port,
  $gr_pickle_receiver_interface = $graphite::params::gr_pickle_receiver_interface,
  $gr_udp_receiver_port = $graphite::params::gr_udp_receiver_port,
  $gr_udp_receiver_interface = $graphite::params::gr_udp_receiver_interface,
  $gr_relay_line_receiver_port = $graphite::params::gr_relay_line_receiver_port,
  $gr_relay_pickle_receiver_interfaces = $graphite::params::gr_relay_pickle_receiver_interfaces,
  $gr_relay_pickle_receiver_port = $graphite::params::gr_relay_pickle_receiver_port,
  $gr_relay_line_receiver_interfaces = $graphite::params::gr_relay_line_receiver_interfaces,

  $gr_django_db_engine = $graphite::params::gr_django_db_engine,
  $gr_django_db_name = $graphite::params::gr_django_db_name,
  $gr_memcache_hosts = $graphite::params::gr_memcache_hosts,
) inherits graphite::params {
  class { 'graphite::install': } ->
  class { 'graphite::config': } ~>
  class { 'graphite::service': } ->
  Class['graphite']
}
