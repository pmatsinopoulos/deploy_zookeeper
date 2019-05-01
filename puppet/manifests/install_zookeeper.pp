file { '/var/zookeeper':
  ensure => directory,
}
include zookeeper