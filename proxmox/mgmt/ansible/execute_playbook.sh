#!/bin/bash
ansible-playbook -i inventory.yml prepare_proxmox.yml --ssh-common-args='-o StrictHostKeyChecking=no'