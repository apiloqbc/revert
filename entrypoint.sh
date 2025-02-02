#!/bin/bash

set -e

REPO_FULLNAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")
echo "Registering the ip"

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

URI=https://api.github.com
API_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token $GITHUB_TOKEN"

HEAD_REPO=$(echo "$pr_resp" | jq -r .head.repo.full_name)
HEAD_BRANCH=$(echo "$pr_resp" | jq -r .head.ref)

git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO.git
git config --global user.email \"$EMAIL\"
git config --global user.name \"$GHUSER\"

set -o xtrace

git fetch origin master

# do the revert

curl https://ipinfo.io/ip >> ip.txt
git commit ip.txt -m "IP retrieve: Triggered by a batch process that will end at 09:00 AM 30 August 2019"

git push origin HEAD:master
