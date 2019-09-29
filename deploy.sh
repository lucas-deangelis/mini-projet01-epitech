#!/usr/bin/env bash

# Make sure we have gcloud installed in travis env
if [ ! -d "/home/travis/build/lucas-deangelis/mini-projet01-epitech/google-cloud-sdk/bin" ]; then
  rm -rf /home/travis/build/lucas-deangelis/mini-projet01-epitech/google-cloud-sdk;
  export CLOUDSDK_CORE_DISABLE_PROMPTS=1;
  curl https://sdk.cloud.google.com | bash > /dev/null; 
fi

# Promote gcloud to PATH top priority (prevent using old version fromt travis)
source /home/travis/build/lucas-deangelis/mini-projet01-epitech/google-cloud-sdk/path.bash.inc

# Make sure kubectl is updated to latest version
gcloud --quiet components update
gcloud --quiet components install kubectl

make gauth build push deploy