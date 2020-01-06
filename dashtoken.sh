#!/bin/sh

# Technique to grab Kubernetes dashboard access token.
# Typically used in Katacoda scenarios.

echo 'To access the dashboard, click on the Kubernetes Dashboard tab above this command '
echo 'line. At the sign in prompt select Token and paste in the token that was just displayed.'
echo ''
echo 'For Kubernetes clusters exposed to the public, always lock administration access including '
echo 'access to the dashboard. Why? https://www.wired.com/story/cryptojacking-tesla-amazon-cloud/'

export TOKEN=$(kubectl describe secret $(kubectl get secret | awk '/^dashboard-token-/{print $1}') | awk '$1=="token:"{print $2}') &&
echo -e "\n--- Copy and paste this token for dashboard access --\n$TOKEN\n---"