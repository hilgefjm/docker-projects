#Remove non-running containers
docker rm -f $(docker ps -qa)

#Remove untagged images
docker rmi -f $(docker images | grep "^<none>" | awk '{print $3}')
docker rmi hilgefjm/nginx

#Build docker image
docker build -rm -t hilgefjm/nginx .
