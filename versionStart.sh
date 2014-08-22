#!/bin/bash
clear

cidFileName="todomvc_cid"
version=`grep version package.json | grep -oe [0-9\.]*`
imagename=`echo "todomvc:$version"`
containername="todomvc"
containerid=`cat $cidFileName`

image=`docker images | grep todomvc | grep -w $version`
container=`docker ps -a | grep $containerid`

echo "removing old container"
docker stop $containerid
docker rm $containerid


if [$image != ""];
then
    echo "removing old image"
    docker rmi $imagename
fi

echo "removing old cidFile"
rm -f -r $cidFileName

echo "building image"
docker build --rm -t $imagename .

#echo todomvc=$(docker run -i -t -v "$PWD:/data" -p 3000:3000 --name "$container" $imagename)
echo "running container"
docker run -i -t -v "$PWD:/data" -p 3000:3000 --cidfile="$cidFileName" $imagename

# clear out nones.
sudo docker rmi $( sudo docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)

#echo "todomvc_cid=$todomvc" > latest




