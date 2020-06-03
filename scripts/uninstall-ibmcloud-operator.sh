#!/usr/bin/env bash

export KUBECONFIG="${KUBECONFIG}"
ibmcloud login -r ${REGION} -g ${RESOURCE_GROUP} --apikey ${APIKEY} > /dev/null

export IC_APIKEY="${APIKEY}"
curl -sL https://raw.githubusercontent.com/IBM/cloud-operators/master/hack/uninstall-operator.sh | bash