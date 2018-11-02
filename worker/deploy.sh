#!/usr/bin/env bash
set -ex

# This is the CI server script to deploy the sidekiq worker
#
# The working directory should be the git root
#
# The caller should have the following environment variables set:
#
# CF_USERNAME: cloudfoundry username
# CF_PASSWORD: cloudfoundry password
# SPACE: the space to which you want to deploy

# Circumvent the cloudfoundry asset compilation step - https://github.com/cloudfoundry/ruby-buildpack/blob/master/src/ruby/finalize/finalize.go#L213
cp -a ./worker/public/. ./web/public/

# Copy the apt packages to be installed
cp ./worker/apt.yml ./web/apt.yml

# Copy the clamav configuration
cp -a ./worker/clamav/. ./web/clamav/

cp ./shared-web ./cosmetics-web/vendor/shared-web 

./ci/install-cf.sh

cf login -a api.cloud.service.gov.uk -u $CF_USERNAME -p $CF_PASSWORD -o 'beis-mspsds' -s $SPACE

cf push -f ./worker/manifest.yml

cf logout
