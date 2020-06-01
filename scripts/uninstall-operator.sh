#!/usr/bin/env bash

export KUBECONFIG="${KUBECONFIG}"
oc login -u apikey -p ${APIKEY} > /dev/null

OPERATOR_GROUP_NAME="${OPERATOR_NAME}-operator-group"

NAMESPACE="openshift-operators"

if [[ -n "${OPERATOR_NAMESPACE}" ]]; then
NAMESPACE="${OPERATOR_NAMESPACE}"
oc delete operatorgroups ${OPERATOR_GROUP_NAME} -n ${NAMESPACE}
fi

oc delete subscription ${OPERATOR_GROUP_NAME} -n ${NAMESPACE}