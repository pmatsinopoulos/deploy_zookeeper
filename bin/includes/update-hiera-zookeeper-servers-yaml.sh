update_hiera_zookeeper_servers_yaml() {
    local SERVERS_FILES_ARRAY=()
    local NAME_FOR_NODE=""
    local EXTRACTED_NODE_INTEGER=0

    SERVERS_FILES_ARRAY=("${HIERA_DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA}"/*)

    cat << EOF > ${SERVERS_FILE}
---
zookeeper::servers:
EOF

    for item in ${SERVERS_FILES_ARRAY[*]}; do

      # remove the yaml file extension
      NAME_FOR_NODE=${item%.yaml}
      # remove the directory path and keep the file name
      NAME_FOR_NODE=$(echo ${NAME_FOR_NODE##*/})

      EXTRACTED_NODE_INTEGER=$(echo ${NAME_FOR_NODE} | cut -d '-' -f2 | cut -d '.' -f 1)

      cat << EOF >> ${SERVERS_FILE}
  '${EXTRACTED_NODE_INTEGER}': '${NAME_FOR_NODE}'
EOF
    done

    cat << EOF >> ${SERVERS_FILE}
zookeeper::client_port: ${ZOOKEEPER_NODE_CLIENT_PORT}
zookeeper::election_port: ${ZOOKEEPER_NODE_ELECTION_PORT}
zookeeper::leader_port: ${ZOOKEEPER_NODE_LEADER_PORT}
EOF
}