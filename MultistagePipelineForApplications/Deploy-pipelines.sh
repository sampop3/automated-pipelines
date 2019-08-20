#!/bin/bash

export ANSIBLE_VAULT_PASSWORD_FILE=~/myPasswordFile.txt

ansible-galaxy install -r requirements.yaml


oc whoami > /dev/null 2>&1


if [ $? -ne 0 ]; then

    echo "ERROR: Please login to the cluster as admin user for creating resources "

    exit 1

fi


if [[ $(ls apps/cool-store) ]]; then

    APPS=$(ls apps/cool-store)
else
    echo "ERROR: No files found in apps/cool-store"
    exit 1
fi

set -e

First_Ocuurance=0


for app in ${APPS}
do 
echo "Creating pipeline for application: $app"
if [ $First_Ocuurance == 0 ]; then
  ansible-playbook -i inventory/ -e @apps/cool-store/${app} generate.yaml
  ansible-playbook -i inventory/ -e @apps/cool-store/${app} apply.yaml
  First_Ocuurance=1
else
  ansible-playbook -i inventory/ -e @apps/cool-store/${app} generate.yaml
  ansible-playbook -i inventory/ -e @apps/cool-store/${app} --limit "app,ci-cd" apply.yaml
fi
echo "Pipeline created for application : $app"
done

