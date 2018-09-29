#!/bin/bash

ssh -t ipo-juku `cat <<EOF
cd ipo-juku &&
git pull origin master &&
docker build -f docker/rails/Dockerfile . -t ipo-juku &&
docker stop \\$(docker ps | grep -v CONTAINER  | cut -d ' ' -f1) &&
docker run -d -p 3000:3000 ipo-juku &&
docker rmi -f \\$(docker images | grep none | sed -r -e 's/ +/ /g' | cut -d ' ' -f3)
EOF`
