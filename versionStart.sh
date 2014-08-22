#!/bin/bash
clear

version=`grep version package.json | grep -oe [0-9\.]*`
imagename=`echo "todomvc:$version"`
containername="todomvc"

image=`docker images | grep todomvc | grep -w $version`
container=`docker ps -a | grep $imagename`

if -n $container
then
    docker stop $container
    docker rm $container
fi

if -n $image
then
    docker rmi $imagename
fi



docker build --rm -t $imagename .

#echo todomvc=$(docker run -i -t -v "$PWD:/data" -p 3000:3000 --name "$container" $imagename)
docker run -i -t -v "$PWD:/data" -p 3000:3000 --name "$container" $imagename
#echo "todomvc_cid=$todomvc" > latest




