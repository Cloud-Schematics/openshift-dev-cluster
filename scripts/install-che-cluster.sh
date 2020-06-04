#!/usr/bin/env bash
export KUBECONFIG="${KUBECONFIG}"

TMP_DIR="./.devtmp"
mkdir -p ${TMP_DIR}

CHE_CLUSTER_YAML_FILE="${TMP_DIR}/${NAME}-che-cluster.yaml"

#curl -sL https://raw.githubusercontent.com/eclipse/che-operator/2.1.1.GA/deploy/crds/org_v1_che_cr.yaml > ${CHE_CLUSTER_YAML_FILE}

cat > "${CHE_CLUSTER_YAML_FILE}" << EOL
apiVersion: org.eclipse.che/v1
kind: CheCluster
metadata:
  name: ${NAME}
  namespace: ${NAMESPACE}
spec:
  server:
    cheImageTag: ''
    cheFlavor: codeready
    devfileRegistryImage: ''
    pluginRegistryImage: ''
    tlsSupport: true
    selfSignedCert: false
  database:
    externalDb: false
    chePostgresHostName: ''
    chePostgresPort: ''
    chePostgresUser: ''
    chePostgresPassword: ''
    chePostgresDb: ''
  auth:
    openShiftoAuth: true
    identityProviderImage: ''
    externalIdentityProvider: false
    identityProviderURL: ''
    identityProviderRealm: ''
    identityProviderClientId: ''
  storage:
    pvcStrategy: per-workspace
    pvcClaimSize: 1Gi
    preCreateSubPaths: true
EOL

until [[ $(oc api-resources | grep checluster | wc -l) -ne 0 ]]; do
  echo "Waiting for the Checluster CRD to become available"
  sleep 10
done

oc apply -f "${CHE_CLUSTER_YAML_FILE}"

until [[ $(oc get checluster "${NAME}" -n "${NAMESPACE}" -o jsonpath='{.status.cheClusterRunning}') == "Available" ]]; do
  echo "Waiting for Eclipse Che to become available"
  sleep 10
done

CHE_URL="$(oc get checluster "${NAME}" -n "${NAMESPACE}" -o jsonpath='{.status.cheURL}')"
echo ">>> CheCluster URL is: ${CHE_URL}"
