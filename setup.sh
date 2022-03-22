#!/usr/bin/env bash

###
# Bash script to setup environment for deploying
# virtual TDP cluster using the TDP-getting-started repo
###

TDP_ROLES_PATH=ansible_roles/collections/ansible_collections/tosit/tdp
TDP_ROLES_EXTRA_PATH=ansible_roles/collections/ansible_collections/tosit/tdp-extra
LOCAL_TDP_BINARIES_DIR=/home/daniel/Desktop/temp/tdp-getting-started/tdp-binaries

# Create directories
mkdir -p logs
mkdir -p files

# Clone ansible-tdp-roles repository (doesn't fail iof not known host)
[[ -d "$TDP_ROLES_PATH" ]] || git clone -o StrictHostKeyChecking=no git@github.com:TOSIT-IO/tdp-collection.git "$TDP_ROLES_PATH"
[[ -d "$TDP_ROLES_EXTRA_PATH" ]] || git clone -o StrictHostKeyChecking=no git@github.com:TOSIT-IO/tdp-collection-extras.git "$TDP_ROLES_EXTRA_PATH"
[[ -d "$TDP_ROLES_PATH" ]] || git clone --branch master -o origin git@github.com:TOSIT-IO/ansible-tdp-roles.git "$TDP_ROLES_PATH"
[[ -d "$TDP_ROLES_EXTRA_PATH" ]] || git clone --branch hue -o origin git@github.com:TOSIT-IO/tdp-collection-extras.git "$TDP_ROLES_EXTRA_PATH"

# Quick fix for file lookup related to the Hadoop role refactor (https://github.com/TOSIT-FR/ansible-tdp-roles/pull/57)
ln -s $PWD/files $TDP_ROLES_PATH/playbooks/files
ln -s $PWD/files $TDP_ROLES_EXTRA_PATH/playbooks/files

# Link the default tdp_vars and tdp_extra_vars
ln -s  $PWD/ansible_roles/collections/ansible_collections/tosit/tdp/tdp_vars_defaults $PWD/inventory/tdp_vars
ln -s  $PWD/ansible_roles/collections/ansible_collections/tosit/tdp-extra/tdp_extra_vars_defaults/* $PWD/inventory/tdp_vars

# Link to local TDP binary directory (until  we go open source)
ln -s $LOCAL_TDP_BINARIES_DIR/* $PWD/files

# Fetch the TDP .tar.gz releases
wget https://github.com/TOSIT-FR/hadoop/releases/download/hadoop-project-dist-3.1.1-TDP-0.1.0-SNAPSHOT/hadoop-3.1.1-TDP-0.1.0-SNAPSHOT.tar.gz
wget https://github.com/TOSIT-FR/hive/releases/download/apache-hive-metastore-3.1.3-TDP-0.1.0-SNAPSHOT/apache-hive-3.1.3-TDP-0.1.0-SNAPSHOT-bin.tar.gz
wget https://github.com/TOSIT-FR/tez/releases/download/tez-0.9.1-TDP-0.1.0-SNAPSHOT/tez-0.9.1-TDP-0.1.0-SNAPSHOT.tar.gz
wget https://github.com/TOSIT-FR/spark/releases/download/spark-2.3.5-TDP-0.1.0-SNAPSHOT/spark-2.3.5-TDP-0.1.0-SNAPSHOT-bin-tdp.tgz
wget https://github.com/TOSIT-FR/ranger/releases/download/ranger-2.0.1-TDP-0.1.0-SNAPSHOT/ranger-2.0.1-TDP-0.1.0-SNAPSHOT-admin.tar.gz
wget https://github.com/TOSIT-FR/ranger/releases/download/ranger-2.0.1-TDP-0.1.0-SNAPSHOT/ranger-2.0.1-TDP-0.1.0-SNAPSHOT-hdfs-plugin.tar.gz
wget https://github.com/TOSIT-FR/ranger/releases/download/ranger-2.0.1-TDP-0.1.0-SNAPSHOT/ranger-2.0.1-TDP-0.1.0-SNAPSHOT-hive-plugin.tar.gz
wget https://github.com/TOSIT-FR/ranger/releases/download/ranger-2.0.1-TDP-0.1.0-SNAPSHOT/ranger-2.0.1-TDP-0.1.0-SNAPSHOT-yarn-plugin.tar.gz
wget https://github.com/TOSIT-FR/ranger/releases/download/ranger-2.0.1-TDP-0.1.0-SNAPSHOT/ranger-2.0.1-TDP-0.1.0-SNAPSHOT-hbase-plugin.tar.gz
wget https://github.com/TOSIT-FR/ranger/releases/download/ranger-2.0.1-TDP-0.1.0-SNAPSHOT/ranger-2.0.1-TDP-0.1.0-SNAPSHOT-usersync.tar.gz
wget https://github.com/TOSIT-IO/phoenix/releases/download/phoenix-hbase-2.1-5.1.3-TDP-0.1.0-SNAPSHOT/phoenix-hbase-2.1-5.1.3-TDP-0.1.0-SNAPSHOT-bin.tar.gz
wget https://github.com/TOSIT-IO/phoenix-queryserver/releases/download/phoenix-queryserver-6.0.0-TDP-0.1.0-SNAPSHOT/phoenix-queryserver-6.0.0-TDP-0.1.0-SNAPSHOT-bin.tar.gz
