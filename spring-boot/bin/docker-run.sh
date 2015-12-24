#!/bin/bash

#for each instance of nginx, rename AND update ports then increment and add new one
IMAGE='test/spring-boot'
PORT=8080
MAX_PORT=8080
INSTANCE_PORT=0
INSTANCE=0
for tmp in $(docker ps -aq --filter='image='$IMAGE); do
	INSTANCE=$(($INSTANCE + 1))
	docker rename $(python getName.py $(docker inspect $tmp)) 'spring-boot-0'$INSTANCE
	INSTANCE_PORT=$(python getPort.py $(docker inspect $tmp))
	if [ "$MAX_PORT" -lt "$INSTANCE_PORT" ]; then
		MAX_PORT=$INSTANCE_PORT
	fi
done
INSTANCE=0
for i in $(docker ps -aq --filter='image='$IMAGE); do
	INSTANCE=$(($INSTANCE + 1))
	docker rename $(python getName.py $(docker inspect $i)) 'spring-boot-'$INSTANCE
done

echo 'Renamed '$INSTANCE' containers.'
if [ "$INSTANCE_PORT" -eq 0 ]; then
	INSTANCE_PORT=$(($MAX_PORT))
else
	INSTANCE_PORT=$(($MAX_PORT + 1))
fi
INSTANCE=$(($INSTANCE + 1))
docker run -d --name='spring-boot-'$INSTANCE -p=$INSTANCE_PORT:$PORT -e JAVA_HOME=/usr/lib/jvm/open-jdk $IMAGE

exit 0
