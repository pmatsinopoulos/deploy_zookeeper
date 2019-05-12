display_usage_information_for_creating_zookeeper_node() {
  echo "You need to give the following 3 arguments:" >&2
  echo "1. The path to the Zookeepers configuration file. e.g. config/zookeepers.cfg." >&2
  echo "2. The Zookeeper node identifier you want to use fo the Zookeeper you will create. For example '1'." >&2
  echo "3. The Subnet index in which Zookeeper node will be created. Valid values 1, 2, 3." >&2
}
