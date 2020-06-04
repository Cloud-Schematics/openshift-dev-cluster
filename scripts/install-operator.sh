#!/usr/bin/env bash
export KUBECONFIG="${KUBECONFIG}"

TMP_DIR="./.devtmp"
mkdir -p ${TMP_DIR}

OPERATOR_YAML_FILE="${TMP_DIR}/${OPERATOR_NAME}-operatorgroup.yaml"
SUBSCRIPTION_YAML_FILE="${TMP_DIR}/${OPERATOR_NAME}-sub.yaml"
OPERATOR_GROUP_NAME="${OPERATOR_NAME}-operator-group"
CHANNEL="latest"
SOURCE="redhat-operators"

if [[ -n "${OPERATOR_CHANNEL}" ]]; then
  CHANNEL="${OPERATOR_CHANNEL}"
fi
if [[ -n "${OPERATOR_SOURCE}" ]]; then
  SOURCE="${OPERATOR_SOURCE}"
fi

NAMESPACE="openshift-operators"

if [[ -n "${OPERATOR_NAMESPACE}" ]]; then
NAMESPACE="${OPERATOR_NAMESPACE}"

oc new-project "${NAMESPACE}"

cat > "${OPERATOR_YAML_FILE}" << EOL
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: ${OPERATOR_GROUP_NAME}
  namespace: ${NAMESPACE}
spec:
  targetNamespaces:
  - ${NAMESPACE}
EOL

oc apply -f "${OPERATOR_YAML_FILE}"
fi


cat > "${SUBSCRIPTION_YAML_FILE}" << EOL
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ${OPERATOR_NAME}
  namespace: ${NAMESPACE}
spec:
  channel: ${CHANNEL}
  installPlanApproval: Automatic
  name: ${OPERATOR_NAME}
  source: ${SOURCE} 
  sourceNamespace: openshift-marketplace 
EOL

oc apply -f "${SUBSCRIPTION_YAML_FILE}"

