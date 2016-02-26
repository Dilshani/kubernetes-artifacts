#!/bin/bash
# ------------------------------------------------------------------------
#
# Copyright 2005-2015 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

# ------------------------------------------------------------------------
set -e

product_name=dss
product_version=3.5.0
minions=$1
image_version=$2
product_profiles=$3

if [ -z "$1" ]
  then
    echo "Usage: ./scp.sh [host-list] [docker-image-version] [product_profile_list]"
    echo "Usage: ./scp.sh 'core@172.17.8.102|core@172.17.8.103' 1.0.0 'worker|manager'"
    exit
fi

if [ -z "$3" ]
  then
    product_profiles='default'
fi

prgdir=`dirname "$0"`
script_path=`cd "$prgdir"; pwd`
common_folder=`cd "${script_path}/../../common/scripts/docker/"; pwd`

echo "Importing docker images to minions"
bash ${common_folder}/scp-cmd.sh ${product_name} ${product_version} ${image_version} ${product_profiles} ${minions}
pid1=$!

wait $pid1
echo "Docker images imported successfully!"
