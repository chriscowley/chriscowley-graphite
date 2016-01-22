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
}
