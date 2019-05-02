file { zookeeper_datalog_store_parent_directory_path:
  # This is necessary, because the module fails to create the datalogstore folder
  # if the parent directory does not exist.
  ensure => directory,
  path   => dirname(lookup("zookeeper::datalogstore", String))
}

include zookeeper

$zookeeper_bins = ['zkCli.sh', 'zkCleanup.sh', 'zkEnv.sh', 'zkServer.sh']

$zookeeper_bins.each | $bin | {
  file { zookeeper_client_in_path:
    ensure => link,
    path   => "/usr/local/bin/${bin}",
    target => "/usr/share/zookeeper/bin/${bin}",
  }
}
