#! /bin/sh
set -ex

echo "Stage 1. Build"

cd webapp
npm install
npm run build
