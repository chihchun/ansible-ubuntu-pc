#!/bin/bash
set -x

HOST=${1:-localhost}
YAML=${2:-desktop.yaml}

ansible-playbook -vv --ask-become-pass --extra-vars="hosts=$HOST" $YAML
