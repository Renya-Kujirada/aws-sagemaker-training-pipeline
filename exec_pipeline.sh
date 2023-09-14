#!/bin/bash

cd `dirname $0`
export PYTHONUNBUFFERED=TRUE
export SAGEMAKER_PROJECT_NAME="mlops-training-pipeline"
export SAGEMAKER_PROJECT_ID="p-vvanybvjhjwe-kujira2"
export SAGEMAKER_PROJECT_NAME_ID="${SAGEMAKER_PROJECT_NAME}-${SAGEMAKER_PROJECT_ID}"
export SAGEMAKER_PIPELINE_NAME="sagemaker-mlops-training-pipeline"
export SAGEMAKER_PIPELINE_ROLE_ARN="arn:aws:iam::081978453918:role/service-role/AmazonSageMakerServiceCatalogProductsExecutionRole"
export ARTIFACT_BUCKET="sagemaker-project-p-vvanybvjhjwe"
export AWS_REGION="ap-northeast-1"
export LOCAL_MODE="TRUE"

python3 pipelines/run_pipeline.py --module-name pipelines.abalone.pipeline \
          --role-arn $SAGEMAKER_PIPELINE_ROLE_ARN \
          --tags "[{\"Key\":\"sagemaker:project-name\", \"Value\":\"${SAGEMAKER_PROJECT_NAME}\"}, \
                   {\"Key\":\"sagemaker:project-id\", \"Value\":\"${SAGEMAKER_PROJECT_ID}\"}]" \
          --kwargs "{\"region\":\"${AWS_REGION}\", \
                     \"role\":\"${SAGEMAKER_PIPELINE_ROLE_ARN}\", \
                     \"default_bucket\":\"${ARTIFACT_BUCKET}\", \
                     \"pipeline_name\":\"${SAGEMAKER_PROJECT_NAME_ID}\", \
                     \"model_package_group_name\":\"${SAGEMAKER_PROJECT_NAME_ID}\", \
                     \"base_job_prefix\":\"${SAGEMAKER_PROJECT_NAME_ID}\", \
                     \"sagemaker_project_name\":\"${SAGEMAKER_PROJECT_NAME}\", \
                     \"local_mode\":\"${LOCAL_MODE}\"}"

echo "Create/Update of the SageMaker Pipeline and execution completed."
