update_hiera_zookeeper_servers_yaml() {
    local NUMBER_OF_SERVERS=$(ls ${HIERA_DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA} | wc -l)
    echo "NUMBER_OF_SERVER found ${NUMBER_OF_SERVERS}"

    local NAME_FOR_NODE=""

    cat << EOF > ${SERVERS_FILE}
---
zookeeper::servers:
EOF

    for ((i=1; i<=${NUMBER_OF_SERVERS};i++)); do

      NAME_FOR_NODE="${ZOOKEEPER_NODE_STACK_NAME}-${i}"
      NAME_FOR_NODE=$(echo ${NAME_FOR_NODE} | tr [:upper:] [:lower:]).${DOMAIN_NAME}

      echo "(index: ${i}): About to add the node ${NODE_FOR_NAME} into ${SERVERS_FILE}..."

      cat << EOF >> ${SERVERS_FILE}
  - '${NAME_FOR_NODE}'
EOF

    done

}