BUILD_DIR=build
S3_BUCKET_NAME=tyli-academy
S3_PREFIX=lambda-api/sam
STACK_NAME=tyli-academy-lambda-sam
CF_TEMPLATE=template.yaml

build:
	sam build -t ${CF_TEMPLATE}

run:
	sam local invoke -t ${CF_TEMPLATE}

deploy: build
	sam deploy \
		--capabilities CAPABILITY_NAMED_IAM \
		--s3-bucket ${S3_BUCKET_NAME} \
		--s3-prefix ${S3_PREFIX} \
		--stack-name ${STACK_NAME}

destroy:
	aws cloudformation delete-stack --stack-name ${STACK_NAME}