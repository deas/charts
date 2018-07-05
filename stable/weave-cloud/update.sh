#!/bin/sh -eux

# A Weave Cloud user is usually expect to install the agents using one simple command like this:
#   kubectl create -n kube-system 'https://cloud.weave.works/k8s/v1.6/weave-cloud?t=<service_token>'
#
# There is service that generates manifest based on the parameters passed in the URL.
# This chart simply checks-in the YAML manifest generated by the service, and this script is used to
# update the chart.

for manifest in flux scope cortex ; do
  curl --silent --location \
    --get "https://cloud.weave.works/k8s/v1.6/${manifest}" \
    --data-urlencode "service-token={{.Values.ServiceToken}}" \
    --data-urlencode "omit-support-info=true" \
    --output "./templates/${manifest}.yaml"
done