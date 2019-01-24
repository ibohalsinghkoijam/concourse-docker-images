#!/bin/bash

set -ex

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export fly_target=${fly_target:-tutorial}
echo "Concourse API target ${fly_target}"
echo "Tutorial $(basename $DIR)"

pushd $DIR
  fly -t ${fly_target} sp -p olive-pipeline -c pipeline.yml -n
  fly -t ${fly_target} up -p olive-pipeline
  fly -t ${fly_target} trigger-job -j olive-pipeline/publish -w
popd
