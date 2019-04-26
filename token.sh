#!/bin/sh

# To install the default Kubernetes dashboard into your cluster use the Helm chart:
# helm upgrade --install kubernetes-dashboard --namespace kube-system  stable/kubernetes-dashboard --set fullnameOverride="kubernetes-dashboard" > /dev/null 2>&1
# 
# Access to the dashboard exposes a large security hole 
# https://arstechnica.com/information-technology/2018/02/tesla-cloud-resources-are-hacked-to-run-cryptocurrency-mining-malware/
# Ensure the dashboard access it limited to just administrators. A recommended practice is with 
# the Kubernetes proxy command:
# kubectl proxy&

# The dashboard service can then be accessed from the url:
# http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:https/proxy/

# Your Kubernetes dashboard should be secure, but you will need the bearer token. 
# With admin rights to kubectl, run this script post the token to your clipboard to make it available to paste into the prompt.
ADMIN_SECRET="$(kubectl -n kube-system get secret -o=name | grep 'admin-user')"
TOKEN="$(kubectl -n kube-system get $ADMIN_SECRET -o=jsonpath='{..token}')"
TOKEN="$(echo $TOKEN | base64 --decode)"

# Copy token to the administrators operating system's clipboard
if [ "$(uname)" == "Darwin" ]; then
  echo $TOKEN | pbcopy
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo $TOKEN | xclip -selection clipboard -i
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  echo $TOKEN > /dev/clipboard
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  echo $TOKEN > /dev/clipboard
fi

echo "Dashboard token is now in your clipboard."
