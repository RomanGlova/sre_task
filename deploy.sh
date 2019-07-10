#!/usr/bin/env bash

ENV=$1
ACTION=$2
AWS_ACCOUNT_ID=$3
AWS_REGION=$4

if [[ ${ACTION} == "deploy" ]]; then
  case ${ENV} in
  local)
    echo "INFO: Deploying app to ${ENV} env..."
    docker build -t sre_task_web .
    docker-compose up -d
    ;;
  aws)
    echo "INFO: Deploying app to ${ENV} env..."
    docker build -t sre_task_web .
    docker tag sre_task_web:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/sre_task_web:latest
    `aws ecr get-login --no-include-email --region ${AWS_REGION}`
    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/sre_task_web:latest
    terraform init && terraform apply -auto-approve --var-file env.tfvars
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
    terraform init && terraform destroy -auto-approve
    ;;
  *)
    echo "WARNING: Wrong env specified!"
    ;;
  esac
fi