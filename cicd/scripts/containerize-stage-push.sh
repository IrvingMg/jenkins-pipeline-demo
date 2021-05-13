#! /bin/sh
set -ex

echo "Stage 3. Containerize - Push"

echo $REGISTRY_PASSWORD | docker login --username $REGISTRY_USERNAME --password-stdin
docker push irvingmg/web-app:${BUILD_ID}
