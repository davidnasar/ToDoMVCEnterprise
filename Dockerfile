# Pull base image.
FROM dockerfile/python

ENV DEBIAN_FRONTEND noninteractive
# Utilities
RUN apt-get install -y less net-tools inetutils-ping curl telnet nmap socat dnsutils netcat tree

# Install node.js
RUN \
  add-apt-repository -y ppa:chris-lea/node.js && \
  apt-get update && \
  apt-get -y install nodejs && \
  echo '\n# Node.js\nexport PATH="/data/server/node_modules/.bin:$PATH"' >> /root/.bash_profile

RUN /bin/bash -l -c "source /root/.bash_profile"

# Trick to not have bower components redownloaded every time unless package.json was changed.
ADD bower.json /tmp/bower/bower.json
RUN cd /tmp/bower && \
  npm install -g bower && \
  bower --allow-root install && \
  mkdir -p /data/client/ && \
  cp -a /tmp/bower/bower_components /data/client/

# Trick to not have node modules redownloaded every time unless package.json was changed.
ADD server/package.json /tmp/node/package.json
RUN cd /tmp/node && \
  npm install && \
  npm install -g nodemon && \
  mkdir -p /data/server/ && \
  cp -a /tmp/node/node_modules /data/server/

# Add local folder to container
ADD . /data

VOLUME ["/data"]

EXPOSE 3000

WORKDIR /data/server

CMD ["nodemon"]

# sudo docker build -rm -t todomvc .
# sudo docker run -i -t -v "$PWD:/data" -p 3000:3000 --name todomvc todomvc
