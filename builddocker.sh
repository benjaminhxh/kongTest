#!/bin/sh
cd $(dirname $0)
docker image rm kongtest -f
docker image build -t kongtest .
docker run -p 8000:3000 -it kongtest