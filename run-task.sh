#!/bin/bash
set -x

HOST=${1:-localhost}
TASKS=${2:-enablement-focal/tasks/hello.yaml}

ansible-playbook -vv --ask-become-pass --extra-vars="hosts=$HOST" -e task=${TASKS} task-runner.yaml
