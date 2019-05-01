file { zookeeper_datalog_store:
  ensure => directory,
  path => $zookeeper['datalogstore']
}

include zookeeper