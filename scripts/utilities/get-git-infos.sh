#/usr/bin/env bash

# This script returns repository local fullpath, remote url and type (github, bitbucket, gitlab, azure, etc)
# Output environment variables:

# Local fullpath:  $GIT_ROOT
# Remote url:      $GIT_REMOTE_URL
# Repository type: $GIT_TYPE

# GIT_ROOT: ./get-git-infos.sh | cut -d ' ' -f 1
# GIT_REMOTE_URL: ./get-git-infos.sh | cut -d ' ' -f 2
# GIT_TYPE: ./get-git-infos.sh | cut -d ' ' -f 3

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export GIT_ROOT="$(cd $SCRIPT_DIR && git rev-parse --show-toplevel)"
export GIT_REMOTE_URL="$(cd $GIT_ROOT && git ls-remote --get-url origin)"
export GIT_TYPE="NA"

if [ $(echo "$GIT_REMOTE_URL" | grep -c 'github.com') -gt 0 ]; then
export GIT_TYPE="github"
elif [ $(echo "$GIT_REMOTE_URL" | grep -c 'bitbucket.org') -gt 0 ]; then
export GIT_TYPE="bitbucket"
elif [ $(echo "$GIT_REMOTE_URL" | grep -c 'gitlab') -gt 0 ]; then
export GIT_TYPE="gitlab"
elif [ $(echo "$GIT_REMOTE_URL" | grep -c 'azure') -gt 0 ]; then
export GIT_TYPE="azure"
fi

echo "$GIT_ROOT $GIT_REMOTE_URL $GIT_TYPE"