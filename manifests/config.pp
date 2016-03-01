# == Class graphite::config
#
# This class is meant to be called from graphite
# It sets variables according to platform
#
class graphite::config {
  file { '/etc/carbon/storage-schemas.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('graphite/storage-schemas.conf.erb')
  }
  file { '/etc/carbon/relay-rules.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('graphite/relay-rules.conf.erb'),
  }
  file { '/etc/carbon/carbon.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('graphite/carbon.conf.erb'),
  }
  file { '/etc/graphite-web/local_settings.py':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('graphite/graphite-web_local_settings.py.erb'),
  }

  exec { 'create graphite db':
    path        => '/etc/graphite-web/local_settings.py',
    command     => 'python manage.py syncdb --noinpput',
    cwd         => '/usr/lib/python2.6/site-packages/graphite/',
    refreshonly => true,
    require     => File['/etc/graphite-web/local_settings.py'],
    #  subscribe   => Class['graphite::install'],
    user        => 'apache',
  }
  file {'/etc/carbon-c-relay.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('graphite/carbon-c-relay.conf.erb'),
    notify  => Service[$::graphite::carbon_relay_service]
  }
}
