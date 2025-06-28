#!/bin/bash
ansible-playbook -i inventory.yml prepare_zabbix_server.yml --ssh-common-args='-o StrictHostKeyChecking=no'