# Pull base image.
FROM dockerfile/python

#Utilities
RUN apt-get install -y less net-tools inetutils-ping curl telnet nmap socat dnsutils netcat tree

# Install node.js
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  echo '\n# Node.js\nexport PATH="/data/server/node_modules/.bin:$PATH"' >> /root/.bash_profile

RUN /bin/bash -l -c "source /root/.bash_profile"

# Add local folder to container
ADD . /data
ADD bower.json /data/bower.json
ADD package.json /data/server/package.json

VOLUME ["/data"]

EXPOSE 3000

RUN cd /data && \
  npm install -g bower && \
  bower --allow-root install && \
  npm install -g nodemon && \
  cd /data/server/ && \
  npm install

WORKDIR /data/server

#ENTRYPOINT ["nodemon"]

#CMD [""]

# sudo docker build -rm -t todomvc .
# sudo docker run -i -t -v "$PWD:/data" -p 3000:3000 --name todomvc todomvc
