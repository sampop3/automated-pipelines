#!/bin/bash

export ANSIBLE_VAULT_PASSWORD_FILE=~/myPasswordFile.txt

ansible-galaxy install -r ./requirements.yaml


oc whoami > /dev/null 2>&1


if [ $? -ne 0 ]; then

    echo "ERROR: Please login to the cluster as admin user for creating resources "

    exit 1

fi


if [[ $(ls inventory/group_vars/) ]]; then

    IMAGES_SOURCE=$(ls inventory/group_vars/)
else
    echo "ERROR: No files found in inventory/group_vars/"
    exit 1
fi

set -e

First_Ocuurance=0


for image in ${IMAGES_SOURCE}
do 
  echo "Creating pipeline for image: $image"
  ansible-playbook -i inventory/ -e @inventory/group_vars/${image}  apply.yaml
  sleep 2m
  echo "Pipeline created for image: $image"
done
