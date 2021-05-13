#! /bin/sh
set -ex

echo "Stage 4. Deploy"

echo $REGISTRY_PASSWORD | docker login --username $REGISTRY_USERNAME --password-stdin
docker stop webapp || true 
docker rm webapp || true
docker run -d --name webapp -p 8080:80 irvingmg/web-app:${BUILD_ID}
