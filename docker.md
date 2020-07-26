# Docker - 容器化解决方案

* Remove all images

docker rmi $(docker images -qf "dangling=true”)

* Remove all images except "my-image"

Use grep to remove all except my-image and ubuntu
docker rmi $(docker images | grep -v 'ubuntu\|my-image' | awk {'print $3'})

* Kill containers and remove them:

docker rm $(docker kill $(docker ps -aq))
