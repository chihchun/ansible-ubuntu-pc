#!/bin/bash
set -x

HOST=${1:-localhost}
JOB=${2:-com.canonical.certification::smoke}
TASKS=enablement-focal/tasks/checkbox-runner.yaml

ansible-playbook -vv --extra-vars="hosts=$HOST" --extra-vars="task=${TASKS}" --extra-vars="checkbox_job=${JOB}" task-runner.yaml
