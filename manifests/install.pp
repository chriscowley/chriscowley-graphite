# == Class graphite::install
#
# This class is meant to be called from graphite
# It sets variables according to platform
#
class graphite::install {
  package { $::graphite::graphite_package:
    ensure => present,
  }
  package { $::graphite::carbon_package :
    ensure => present,
  }
  package { $::graphite::whisper_package:
    ensure => present,
  }
  if $::graphite::relay_type == 'c' {
    package { $::graphite::relay_package:
      ensure  => present,
    }
    file { '/var/log/carbon-c-relay/carbon-c-relay.log':
      owner   => 'carbon-c-relay',
      group   => 'carbon-c-relay',
      mode    => '600',
      require => Package[$::graphite::relay_package],
    }
  }
}
