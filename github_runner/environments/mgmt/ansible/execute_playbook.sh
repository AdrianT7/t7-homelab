#!/bin/bash
ansible-playbook -i inventory.yml prepare_gh_runner_host.yml --ssh-common-args='-o StrictHostKeyChecking=no'