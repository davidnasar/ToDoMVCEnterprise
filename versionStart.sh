#!/bin/bash
clear

echo "start"

cidFileName="todomvc_cid"
version=`grep version server/package.json | grep -oe [0-9\.]*`

echo $version
imagename=`echo "todomvc:$version"`
containername="todomvc"
containerid=`cat $cidFileName`

image=`docker images | grep todomvc | grep -w $version`
echo "image is $image"

container=`docker ps -a | grep "$containerid"`
echo "container is $container"

echo "removing old container"
docker stop $containerid
docker rm $containerid

echo $image

echo "image name is $imagename"

echo "checking image"
if [[ -z $image ]]
then
    echo "removing old images"
    sudo docker rmi $( sudo docker images | grep 'todomvc' | tr -s ' ' | cut -d ' ' -f 3)
    sudo docker rmi $( sudo docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)
    echo "building new image - $imagename"
    docker build --rm -t $imagename .
fi

echo "removing old cidFile"
rm -f -r $cidFileName

# clear out nones.
#

echo "running container"
docker run -i -t -v "$PWD:/data" -p 3000:3000 --cidfile="$cidFileName" $imagename nodemon


#echo "todomvc_cid=$todomvc" > latest
