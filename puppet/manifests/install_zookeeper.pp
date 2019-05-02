file { zookeeper_datalog_store_parent_directory_path:
  # This is necessary, because the module fails to create the datalogstore folder
  # if the parent directory does not exist.
  ensure => directory,
  path => dirname(lookup("zookeeper::datalogstore", String))
}

include zookeeper