#!/usr/bin/env bash

ENV=$1

case ${ENV} in
local)
  echo "INFO: Deploying app to ${ENV} env..."
  ;;
aws)
  echo "INFO: Deploying app to ${ENV} env..."
  ;;
*)
  echo "WARNING: Wrong env specified!"
  ;;
esac
