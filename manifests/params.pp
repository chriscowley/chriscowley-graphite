# == Class graphite::params
#
# This class is meant to be called from graphite
# It sets variables according to platform
#
class graphite::params {
  case $::osfamily {
    'Redhat', 'Amazon': {
      $manage_epel = false
      case $::operatingsystemmajrelease {
        6: {
          $graphite_package = 'graphite-web'
          $carbon_package = 'python-carbon'
          $whisper_package = 'python-whisper'
          $carbon_relay_service = 'carbon-relay'
          $carbon_cache_service = 'carbon-cache'
        }
        default: {
          fail("${::operatingsystem} $::operatingsystemmajrelease not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $vhost_name = undef
}
