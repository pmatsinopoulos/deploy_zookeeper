update_hiera_zookeeper_servers_yaml() {
    local SERVERS_FILES_ARRAY=()
    read -r -a SERVERS_FILES_ARRAY <<< $(ls ${HIERA_DIRECTORY_WITH_ZOOKEEPER_HOSTS_DATA})

    local NAME_FOR_NODE=""

    cat << EOF > ${SERVERS_FILE}
---
zookeeper::servers:
EOF

    for item in ${SERVERS_FILES_ARRAY[*]}; do

      NAME_FOR_NODE=${item%.yaml}

      echo "About to add the node ${NAME_FOR_NODE} into ${SERVERS_FILE}..."

      local EXTRACTED_NODE_INTEGER=$(echo ${NAME_FOR_NODE} | cut -d '-' -f2 | cut -d '.' -f 1)

      cat << EOF >> ${SERVERS_FILE}
  '${EXTRACTED_NODE_INTEGER}': '${NAME_FOR_NODE}'
EOF

    done

}