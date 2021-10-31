#!/bin/bash

docker build -t xiaomi-firmware-builder .
docker run --rm -v $(pwd)/backed-firmware:/opt/backed-firmware xiaomi-firmware-builder