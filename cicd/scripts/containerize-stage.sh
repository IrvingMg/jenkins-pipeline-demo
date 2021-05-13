#! /bin/sh
set -ex

echo "Stage 3. Containerize"

echo $REGISTRY_PASSWORD | docker login --username $REGISTRY_USERNAME --password-stdin
docker build -t irvingmg/test:${BUILD_ID} .
docker push irvingmg/test:${BUILD_ID}
