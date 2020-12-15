#! /bin/bash

ECS_PASSWORD="$(aws ecr get-login-password --region us-east-1)"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo $ECS_PASSWORD | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
docker build -f lambdas/Dockerfile -t hma-lambda-dev lambdas
docker tag hma-lambda-dev ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/hma-lambda-dev
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/hma-lambda-dev
