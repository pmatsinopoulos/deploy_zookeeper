file { zookeeper_datalog_store:
  ensure => directory,
  path => lookup("zookeeper::datalogstore", String)
}

include zookeeper