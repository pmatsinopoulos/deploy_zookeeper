update_hiera_zookeeper_servers_yaml() {
    local NUMBER_OF_SERVERS=$(ls -l ${HIERA_DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA}/*.yaml | wc -l)
    local NAME_FOR_NODE=""

    cat << EOF > ${SERVERS_FILE}
---
zookeeper::servers:
EOF

    for ((i=1; i<=${NUMBER_OF_SERVERS};i++)); do

      NAME_FOR_NODE="${ZOOKEEPER_NODE_STACK_NAME}-${i}"
      NAME_FOR_NODE=$(echo ${NAME_FOR_NODE} | tr [:upper:] [:lower:]).${DOMAIN_NAME}

      cat << EOF >> ${SERVERS_FILE}
  - '${NAME_FOR_NODE}'
EOF

    done

}