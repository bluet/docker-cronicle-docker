#!/bin/bash

VERSION=0.8.62

docker build -t bluet/cronicle-docker .
docker scan bluet/cronicle-docker:latest
#docker tag bluet/cronicle-docker:latest bluet/cronicle-docker:0.8.62
#git tag "0.8.62" -a -m "docker 20.10, cronicle 0.8.62"
#git push --tags
# docker run --privileged -it --rm tonistiigi/binfmt --install all
# docker buildx create --use

while true; do
        read -p "Have I Updated VERSION Info? (Is current VERSION=${VERSION} ?) [y/N]" yn
        case $yn in
                [Yy]* ) docker buildx build -t bluet/cronicle-docker:latest -t bluet/cronicle-docker:${VERSION} --platform linux/amd64,linux/arm64/v8 --push .; break;;
                [Nn]* ) exit;;
                * ) echo "";;
        esac
done


