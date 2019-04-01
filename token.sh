#!/bin/sh

# Your Kubernetes dashboard should be secure, but often you need the token. 
# With admin rights to kubectl, run this script to grab the bearer token to provide to the dashboard.

kubectl describe secret $(kubectl get secret | awk '/^dashboard-token-/{print $1}') | awk '$1=="token:"{print $2}' | xclip -selection clipboard -i

echo "Dashboard token is now in your clipboard."
