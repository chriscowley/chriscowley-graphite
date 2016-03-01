# == Class graphite::params
#
# This class is meant to be called from graphite
# It sets variables according to platform
#
class graphite::params {
  $gr_max_updates_per_second = 500
  $gr_max_updates_per_second_on_shutdown = 1000
  $gr_max_creates_per_minute = 50
  $gr_line_receiver_port = 2013
  $gr_line_receiver_interface = '0.0.0.0'
  $gr_udp_receiver_port = undef
  $gr_udp_receiver_interface = '0.0.0.0'
  $gr_pickle_receiver_port = 2014
  $gr_pickle_receiver_interface = '0.0.0.0'
  
  $gr_relay_line_receiver_port = 2003
  $gr_relay_line_receiver_interface = '0.0.0.0'
  $gr_relay_pickle_receiver_port = 2003
  $gr_relay_pickle_receiver_interface = '0.0.0.0'
  

  $vhost_name = undef
  $gr_storage_schemas = undef
  $gr_relay_rules = undef
  $secret_key = 'secret'

  $gr_django_db_engine = 'django.db.backends.sqlite3'
  $gr_django_db_name = '/var/lib/graphite-web/graphite.db'
  $gr_memcache_hosts = undef
  $relay_type = 'c'
  case $::osfamily {
    'Redhat', 'Amazon': {
      $manage_epel = false
      case $::operatingsystemmajrelease {
        6: {
          $graphite_package = 'graphite-web'
          $carbon_package = 'python-carbon'
          $whisper_package = 'python-whisper'
          case $relay_type {
            'c': {
              $relay_package = 'carbon-c-relay'
              $carbon_relay_service = 'carbon-c-relay'
            }
            'python': {
              $carbon_relay_service = 'carbon-relay'
            }
          }
          $carbon_cache_service = 'carbon-cache'
        }
        default: {
          fail("${::operatingsystem} $::operatingsystemmajrelease not supported")
        }
      }
      $gr_storage_dir = '/var/lib/carbon/'
      $gr_local_data_dir = "${gr_storage_dir}whisper/"
      $gr_whitelists_dir = "${gr_storage_dir}lists/"
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
