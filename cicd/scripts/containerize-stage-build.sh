#! /bin/sh
set -ex

echo "Stage 3. Containerize - Build"

docker build -t irvingmg/web-app:${BUILD_ID} .
