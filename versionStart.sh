#!/bin/bash
clear

cidFileName="todomvc_cid"
version=`grep version package.json | grep -oe [0-9\.]*`
imagename=`echo "todomvc:$version"`
containername="todomvc"
containerid=`cat $cidFileName`

image=`docker images | grep todomvc | grep -w $version`
container=`docker ps -a | grep containerid`


if [$container != ""];
then
    docker stop CONTAINER $container
    docker rm CONTAINER $container
fi

if [$image != ""];
then
    docker rmi $imagename
fi

rm -f -r $cidFileName

docker build --rm -t $imagename .

#echo todomvc=$(docker run -i -t -v "$PWD:/data" -p 3000:3000 --name "$container" $imagename)
docker run -i -t -v "$PWD:/data" -p 3000:3000 --name "$container" --cidfile="$cidFileName" $imagename
#echo "todomvc_cid=$todomvc" > latest




