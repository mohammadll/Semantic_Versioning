#!/bin/bash
BASE_VERSION=$(cat /var/lib/jenkins/workspace/teller-base-keys_release-base/target/maven-archiver/pom.properties | grep version | cut -d "=" -f2)
version=$(git describe --tags --abbrev=0)
last_commit=$(git log -1 | tail -n 1 | awk '{$1=$1;print}')
regex="([0-9]+)\\.([0-9]+)\\.([0-9]+)"
major=$(git describe --tags --abbrev=0 | grep -Eo "([0-9]+)\\.([0-9]+)\\.([0-9]+)" | cut -d "." -f 1)
minor=$(git describe --tags --abbrev=0 | grep -Eo "([0-9]+)\\.([0-9]+)\\.([0-9]+)" | cut -d "." -f 2)
patch=$(git describe --tags --abbrev=0 | grep -Eo "([0-9]+)\\.([0-9]+)\\.([0-9]+)" | cut -d "." -f 3)
if [[ $version =~ $regex ]]
	 then
if [[ $last_commit == CHANGE:* ]]
	 then
			major=$(echo $major + 1 | bc)
			minor=0
			patch=0
			major_change=$major.$minor.$patch
			mvn clean deploy -Drevision=$major_change -DBASE_VERSION=$BASE_VERSION scm:tag
elif [[ $last_commit == feat:* ]]
	 then
			minor=$(echo $minor + 1 | bc)
			patch=0
			minor_change=$major.$minor.$patch
			mvn clean deploy -Drevision=$minor_change -DBASE_VERSION=$BASE_VERSION scm:tag
elif [[ $last_commit == fix:* ]]
	 then
			patch=$(echo $patch + 1 | bc)
			patch_change=$major.$minor.$patch
			mvn clean deploy -Drevision=$patch_change -DBASE_VERSION=$BASE_VERSION scm:tag
fi
fi
echo "teller base key version: $BASE_VERSION"
