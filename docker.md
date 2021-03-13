# Docker - 容器化解决方案

当一个host中镜像和容器较多，需要重置时可选择删除其中部分或全部的镜像和容器。那么你就需要下面的操作了。

1、删除容器
1）首先需要停止所有的容器
docker stop $(docker ps -a -q) 
2）删除所有的容器（只删除单个时把后面的变量改为image id即可）
docker rm $(docker ps -a -q)

2、删除镜像
1）查看host中的镜像
docker images

2）删除指定id的镜像
docker rmi <image id>
想要删除untagged images，也就是那些id为的image的话可以用 
docker rmi $(docker images | grep "^" | awk "{print $3}")

3）删除全部的images
docker rmi $(docker images -q)

3、当要删除的iamges和其他的镜像有关联而无法删除时


可通过 -f 参数强制删除
docker rmi -f $(docker images -q)
