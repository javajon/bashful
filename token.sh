#!/bin/sh

# This script copies the bearer token for accessing the Kubernetes dashboard to your clipboard. 
# This will work if your local kubectl has admin access to your Kubernetes cluster.
#
# To install the default Kubernetes dashboard into your cluster use the Helm chart:
# helm upgrade --install kubernetes-dashboard --namespace kube-system  stable/kubernetes-dashboard --set fullnameOverride="kubernetes-dashboard"
# 
# Access to the dashboard exposes a large security hole:
# https://arstechnica.com/information-technology/2018/02/tesla-cloud-resources-are-hacked-to-run-cryptocurrency-mining-malware/
#
# So to protect yourself, ensure the dashboard access it limited to just administrators. A 
# recommended practice is with the Kubernetes proxy command:
# kubectl proxy&
#
# With the above proxy, the dashboard service can then be accessed from this URL:
# http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:https/proxy/
#
# Your Kubernetes dashboard should be secure, but you will need the bearer token. With admin rights 
# to kubectl, run this script post the token to your clipboard to make it available to paste into the prompt.

ADMIN_SECRET="$(kubectl -n kube-system get secret -o=name | grep 'admin-user')"
TOKEN="$(kubectl -n kube-system get $ADMIN_SECRET -o=jsonpath='{..token}')"
TOKEN="$(echo $TOKEN | base64 --decode)"

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# Copy token to the administrator's operating system clipboard
if [ $machine == "Mac" ]; then
  echo $TOKEN | pbcopy
elif [ $machine == "Linux" ]; then
  echo $TOKEN | xclip -selection clipboard -i
elif [ $machine == "Cygwin" ]; then
  echo $TOKEN > /dev/clipboard
fi

echo "Dashboard token is now in your $machine clipboard."
