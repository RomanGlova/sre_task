#!/usr/bin/env bash

ENV=$1
ACTION=$2

if [[ ${ACTION} == "deploy" ]]; then
  case ${ENV} in
  local)
    echo "INFO: Deploying app to ${ENV} env..."
    docker build -t sre_task_web .
    docker-compose up -d
    ;;
  aws)
    echo "INFO: Deploying app to ${ENV} env..."
    ;;
  *)
    echo "WARNING: Wrong env specified!"
    ;;
  esac
elif [[ ${ACTION} == "destroy" ]]; then
  case ${ENV} in
  local)
    echo "INFO: Destroying app on ${ENV} env..."
    docker-compose down
    ;;
  aws)
    echo "INFO: Destroying app on ${ENV} env..."
    ;;
  *)
    echo "WARNING: Wrong env specified!"
    ;;
  esac
fi