#!/usr/bin/env bash

# Make sure we have gcloud installed in travis env
if [ ! -d "$HOME/google-cloud-sdk/bin" ]; then
  rm -rf $HOME/google-cloud-sdk;
  export CLOUDSDK_CORE_DISABLE_PROMPTS=1;
  # curl https://sdk.cloud.google.com | bash > /dev/null; 
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-245.0.0-linux-x86_64.tar.gz;
  tar zxvf google-cloud-sdk-245.0.0-linux-x86_64.tar.gz google-cloud-sdk;
  ./google-cloud-sdk/install.sh;
fi

# Promote gcloud to PATH top priority (prevent using old version fromt travis)
source $HOME/google-cloud-sdk/path.bash.inc

# Make sure kubectl is updated to latest version
gcloud --quiet components update
gcloud --quiet components install kubectl

make gauth build push deploy