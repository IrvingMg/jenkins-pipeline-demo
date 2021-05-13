#! /bin/sh
set -ex

echo "Stage 3. Containerize"

echo $REGISTRY_PASSWORD | docker login --username $REGISTRY_USERNAME --password-stdin
docker build -t irvingmg/web-app:${BUILD_ID} .
docker push irvingmg/web-app:${BUILD_ID}
