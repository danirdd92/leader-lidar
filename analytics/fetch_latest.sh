#! /bin/bash

USR=$1
PWD=$2
VERSION=$3


if [[ "$VERSION" != "99-SNAPSHOT" ]]; then
    curl -u ${USR}:${PWD} -O "http://artifactory:8082/artifactory/libs-release-local/com/lidar/telemetry/maven-metadata.xml"
    HIGHEST_PATCH=$(grep -oP "<version>${VERSION}\.[0-9]+</version>" maven-metadata.xml | grep -oP "${VERSION}\.[0-9]+" | sort -V | tail -n1)
    VERSION=$HIGHEST_PATCH
fi

mvn dependency:get -Dartifact=com.lidar:telemetry:$VERSION -Ddest=telemetry.jar