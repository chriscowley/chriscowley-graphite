# == Class graphite::service
#
# This class is meant to be called from graphite
# It sets variables according to platform
#
class graphite::service {
  service { $::graphite::carbon_relay_service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
  service { $::graphite::carbon_cache_service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
