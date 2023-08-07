#!/bin/bash

VERSION=0.9.25

docker build --pull -t bluet/cronicle-docker .
docker scan bluet/cronicle-docker:latest

docker tag bluet/cronicle-docker:latest bluet/cronicle-docker:${VERSION}

# move git tag to last step
#git tag "${VERSION}" -a -m "cronicle ${VERSION}"
#git push
#git push --tags

# Fixes busybox trigger error https://github.com/tonistiigi/xx/issues/36#issuecomment-926876468
docker run --privileged -it --rm tonistiigi/binfmt --install all

docker buildx create --use

while true; do
        read -p "Is VERSION=${VERSION} the current latest version? (We're going to build multi-platform images and push) [y/N]" yn
        case $yn in
                [Yy]* ) docker buildx build -t bluet/cronicle-docker:latest -t bluet/cronicle-docker:${VERSION} --platform linux/amd64,linux/arm64/v8 --pull --push .; break;;
                [Nn]* ) break;;
                * ) echo "";;
        esac
done

read -p "Tag the version of code as ${VERSION} in git? [y/N]" yn
case $yn in
        [Yy]* ) git tag "${VERSION}" -a -m "cronicle ${VERSION}" && git push --tags;;
        * ) echo "";;
esac

